import exif
import Foundation

public class EXIFlatratedData: CustomStringConvertible {
	public package(set) var storage: Storage = [:]

	package private(set) var endianness: ExifByteOrder

	public var description: String {
		let sorted = storage.sorted(by: { $0.key.rawValue < $1.key.rawValue })

		var groups: [String] = []
		for idfGroup in sorted {
			let idf = idfGroup.key
			let sortedGroup = idfGroup
				.value
				.sorted(by: { $0.key.description < $1.key.description })
				.map { "\t\($0.key): \($0.value)" }
			groups.append("\(idf):\n\(sortedGroup.joined(separator: "\n"))")
		}
		return groups.joined(separator: "\n")
	}

	public subscript(ifd: ExifIfd) -> [ExifTag: ExifRawData] {
		storage[ifd] ?? [:]
	}

	public subscript(tuple: (ifd: ExifIfd, tag: ExifTag)) -> ExifRawData? {
		self[Path(folder: tuple.ifd, tag: tuple.tag)]
	}

	public struct Path {
		let folder: ExifIfd
		let tag: ExifTag
	}

	public subscript(path: Path) -> ExifRawData? {
		guard
			let directory = storage[path.folder]
		else { return nil }

		return directory[path.tag]
	}

	public init(fileURL: URL) throws(Error) {
		let imagePath = fileURL.path(percentEncoded: false)

		guard
			let exifDataPointer = exif_data_new_from_file(imagePath)
		else { throw .failedOpeningFile }
		defer { exif_data_unref(exifDataPointer) }

		self.endianness = exif_data_get_byte_order(exifDataPointer)

		withRawPointer { pp in
			exif_data_foreach_content(exifDataPointer, exifForeachIterator, pp)
		}
	}

	public init(imageData: Data) throws(Error) {
		self.endianness = .little

		var data = imageData
		func block(buffer: UnsafeMutableRawBufferPointer) throws(EXIFlatratedData.Error) -> Void {
			guard
				let exifDataPointer = exif_data_new_from_data(buffer.baseAddress, UInt32(buffer.count))
			else { throw .failedDecodingData }
			defer { exif_data_unref(exifDataPointer) }

			self.endianness = exif_data_get_byte_order(exifDataPointer)

			withRawPointer { pp in
				exif_data_foreach_content(exifDataPointer, exifForeachIterator, pp)
			}
		}
		do {
			try data.withUnsafeMutableBytes(block)
		} catch let error as Error {
			throw error
		} catch {
			fatalError("Impossible")
		}
	}

	package static func from(pointer: UnsafeMutableRawPointer) -> EXIFlatratedData {
		let typed = pointer.bindMemory(to: EXIFlatratedData.self, capacity: 1)
		return typed.pointee
	}

	package func withRawPointer(_ block: (UnsafeMutablePointer<EXIFlatratedData>) throws -> Void) rethrows {
		var this = self
		try withUnsafeMutablePointer(to: &this) { pointer in
			try block(pointer)
		}
	}

	public enum Error: Swift.Error {
		case failedOpeningFile
		case failedDecodingData
	}
}

extension EXIFlatratedData: Collection {
	public func index(after i: Storage.Index) -> Storage.Index { storage.index(after: i) }

	public subscript(position: Storage.Index) -> Storage.Element { storage[position] }

	public typealias Storage = [ExifIfd: [ExifTag: ExifRawData]]
	public typealias Index = Storage.Index
	public typealias Element = Storage.Element

	public var startIndex: Storage.Index { storage.startIndex }
	public var endIndex: Storage.Index { storage.endIndex }
}

private func exifForeachIterator(
	contentPointer: UnsafeMutablePointer<ExifContent>?,
	userDataPointer: UnsafeMutableRawPointer?
) {
	guard
		let userData = userDataPointer.map({ EXIFlatratedData.from(pointer: $0) }),
		let contentPointer
	else { return }

	let ifd = exif_content_get_ifd(contentPointer)

	let content = contentPointer.pointee
	for i in 0..<Int(content.count) {

		guard
			let entryPointer = content.entries.advanced(by: i).pointee
		else { continue }

		let exifRawData = ExifRawData(from: entryPointer.pointee, ifd: ifd, endianness: userData.endianness)
		userData.storage[ifd, default: [:]][exifRawData.tag] = exifRawData
	}
}
