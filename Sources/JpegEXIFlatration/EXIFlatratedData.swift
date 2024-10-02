import exif
import Foundation

public class EXIFlatratedData: CustomStringConvertible {
	public package(set) var dictionary: [ExifIfd: [ExifTag: ExifRawData]] = [:]

	package private(set) var endianness: ExifByteOrder

	public var description: String {
		let sorted = dictionary.sorted(by: { $0.key.rawValue < $1.key.rawValue })

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

	public init(fileURL: URL) throws(Error) {
		let imagePath = fileURL.path(percentEncoded: false)

		guard
			let exifDataPointer = exif_data_new_from_file(imagePath)
		else { throw .failedOpeningFile }
		defer { exif_data_unref(exifDataPointer) }

		self.endianness = exif_data_get_byte_order(exifDataPointer)

		exif_data_foreach_content(exifDataPointer, exifForeachIterator, pointer)
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

			exif_data_foreach_content(exifDataPointer, exifForeachIterator, pointer)
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

	package var pointer: UnsafeMutableRawPointer {
		let typedPointer = UnsafeMutablePointer<EXIFlatratedData>.allocate(capacity: 1)
		typedPointer.pointee = self
		let rawPointer = UnsafeMutableRawPointer(typedPointer)

		return rawPointer
	}

	public enum Error: Swift.Error {
		case failedOpeningFile
		case failedDecodingData
	}
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
		userData.dictionary[ifd, default: [:]][exifRawData.tag] = exifRawData
	}
}
