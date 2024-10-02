import Foundation
import Testing
import JpegEXIFlatration

import exif


@Test
func testCanon40DFileInit() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")!

	let data = try EXIFlatratedData(fileURL: imageURL)

	try verifyCanon40d(data)
}

@Test
func testCanond40DDataInit() async throws {
	let imageURL = Bundle.module.url(forResource: "Canon_40D", withExtension: "jpg")!
	let imageData = try Data(contentsOf: imageURL)

	let data = try EXIFlatratedData(imageData: imageData)

	try verifyCanon40d(data)
}

func verifyCanon40d(_ data: EXIFlatratedData) throws {
	let expectedIFDs: Set<ExifIfd> = [.ifd0, .ifd1, .exif, .gps, .interoperability]
	#expect(Set(data.dictionary.keys) == expectedIFDs)

	// sample parts
	#expect(data.dictionary[.ifd0]?[.orientation]?.libexifString == "Top-left")
	#expect(data.dictionary[.ifd1]?[.compression]?.libexifString == "JPEG compression")
	#expect(data.dictionary[.exif]?[.exposureTime]?.libexifString == "1/160 sec.")
	#expect(data.dictionary[.gps]?[.gpsVersionId]?.libexifString == "2.2.0.0")
	#expect(data.dictionary[.interoperability]?[.interoperabilityIndex]?.libexifString == "R98")
}

enum TestError: Error {
	case fail
}
