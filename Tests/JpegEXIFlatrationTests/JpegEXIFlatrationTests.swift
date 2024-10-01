import Foundation
import Testing
import JpegEXIFlatration

import exif


@Test
func testRawExifFunctions() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")!

	let userData = try EXIFlatratedData(fileURL: imageURL)

	print(userData)
}

@Test
func testDataInit() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")!
	let imageData = try Data(contentsOf: imageURL)

	let userData = try EXIFlatratedData(imageData: imageData)

	print(userData)
}

enum TestError: Error {
	case fail
}
