import Foundation
import exif

public struct ExifRawData: Sendable, Hashable {
	public var rawData: Data
	public let name: String?
	public let tag: ExifTag
	public let libexifString: String?
	public let endianness: ExifByteOrder
	public let dataFormat: ExifFormat
	public let componentCount: UInt

	public init(
		rawData: Data,
		name: String?,
		tag: ExifTag,
		libexifString: String?,
		endianness: ExifByteOrder,
		dataFormat: ExifFormat,
		componentCount: UInt
	) {
		self.rawData = rawData
		self.name = name
		self.tag = tag
		self.libexifString = libexifString
		self.endianness = endianness
		self.dataFormat = dataFormat
		self.componentCount = componentCount
	}

	public init(from entry: ExifEntry, ifd: ExifIfd, endianness: ExifByteOrder) {
		var entry = entry
		let entryData = Data(bytes: entry.data, count: Int(entry.size))
		let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 1024, alignment: 4)
		defer { buffer.deallocate() }
		exif_entry_get_value(&entry, buffer.baseAddress, UInt32(buffer.count))

		let value: String? = {
			let valueBuffer = buffer.bindMemory(to: CChar.self)
			return valueBuffer.baseAddress.map {
				String(cString: $0)
			}
		}()

		let name = exif_tag_get_name_in_ifd(entry.tag, ifd).map { String(cString: $0) }

		self.init(
			rawData: entryData,
			name: name,
			tag: entry.tag,
			libexifString: value,
			endianness: endianness,
			dataFormat: entry.format,
			componentCount: entry.components)
	}

	public var asString: String? {
		String(data: rawData, encoding: .utf8)
	}
}
