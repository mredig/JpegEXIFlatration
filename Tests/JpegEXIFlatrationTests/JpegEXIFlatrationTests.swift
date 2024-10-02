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

	typealias Rational = ExifRawData.RationalValue

	// sample parts
	#expect(data.dictionary[.ifd0]?[.orientation]?.libexifString == "Top-left")
	#expect(data.dictionary[.ifd1]?[.compression]?.libexifString == "JPEG compression")
	#expect(data.dictionary[.exif]?[.exposureTime]?.libexifString == "1/160 sec.")
	#expect(data.dictionary[.exif]?[.exposureTime]?.asRational == Rational(numerator: 1, denominator: 160))
	#expect(data.dictionary[.exif]?[.focalPlaneResolutionUnit]?.asShort == 2)
	#expect(data.dictionary[.exif]?[.apertureValue]?.asRational == Rational(numerator: 368640, denominator: 65536))
	#expect(data.dictionary[.exif]?[.apertureValue]?.asRational?.reduced() == Rational(numerator: 45, denominator: 8))
	#expect(data.dictionary[.exif]?[.apertureValue]?.libexifString == "5.62 EV (f/7.0)")
	#expect(data.dictionary[.exif]?[.shutterSpeedValue]?.asSignedRational == Rational(numerator: 483328, denominator: 65536))
	#expect(data.dictionary[.exif]?[.shutterSpeedValue]?.asSignedRational?.reduced() == Rational(numerator: 59, denominator: 8))
	#expect(data.dictionary[.gps]?[.gpsVersionId]?.libexifString == "2.2.0.0")
	#expect(data.dictionary[.interoperability]?[.interoperabilityIndex]?.libexifString == "R98")
}

enum TestError: Error {
	case fail
}
