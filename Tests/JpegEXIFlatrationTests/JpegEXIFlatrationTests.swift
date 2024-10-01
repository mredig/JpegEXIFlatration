import Foundation
import Testing
import JpegEXIFlatration

import exif


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
		let buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: 1024, alignment: 4)
		defer { buffer.deallocate() }
		guard
			let entry = content.entries.advanced(by: i).pointee
		else { continue }
		exif_entry_get_value(entry, buffer.baseAddress, UInt32(buffer.count))

		let valueBuffer = buffer.bindMemory(to: CChar.self)
		guard
			let valueBufferCStr = valueBuffer.baseAddress,
			let nameCStr = exif_tag_get_name_in_ifd(entry.pointee.tag, ifd)
		else { continue }

		let name = String(cString: nameCStr)
		let value = String(cString: valueBufferCStr)
		userData.dictionary[ifd, default: [:]][name] = value
	}
}

@Test
func testRawExifFunctions() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")
	let imagePath = imageURL!.path(percentEncoded: false)

	guard
		let exifDataPointer = exif_data_new_from_file(imagePath)
	else { throw TestError.fail }

	let userData = EXIFlatratedData()

	exif_data_foreach_content(exifDataPointer, exifForeachIterator, userData.pointer)

	print(userData)
}

enum TestError: Error {
	case fail
}
