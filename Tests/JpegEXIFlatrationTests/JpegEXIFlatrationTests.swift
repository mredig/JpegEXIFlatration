import Foundation
import Testing
import JpegEXIFlatration

import exif


@Test
func testFileInit() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")!

	let data = try EXIFlatratedData(fileURL: imageURL)

	try verifyCanon40d(data)
}

@Test
func testDataInit() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")!
	let imageData = try Data(contentsOf: imageURL)

	let data = try EXIFlatratedData(imageData: imageData)

	try verifyCanon40d(data)
}

func verifyCanon40d(_ data: EXIFlatratedData) throws {
	let expectedIFDs: Set<ExifIfd> = [.ifd0, .ifd1, .exif, .gps, .interoperability]
	#expect(Set(data.dictionary.keys) == expectedIFDs)

	// sample parts
	#expect(data.dictionary[.ifd0]?["Orientation"] == "Top-left")
	#expect(data.dictionary[.ifd1]?["Compression"] == "JPEG compression")
	#expect(data.dictionary[.exif]?["ExposureTime"] == "1/160 sec.")
	#expect(data.dictionary[.gps]?["GPSVersionID"] == "2.2.0.0")
	#expect(data.dictionary[.interoperability]?["InteroperabilityIndex"] == "R98")
}

enum TestError: Error {
	case fail
}
