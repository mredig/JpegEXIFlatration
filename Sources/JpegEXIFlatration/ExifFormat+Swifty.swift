import exif
import Foundation

extension ExifFormat: @retroactive CustomStringConvertible {
	public static let byte = ExifFormat(1)
	public static let ascii = ExifFormat(2)
	public static let short = ExifFormat(3)
	public static let long = ExifFormat(4)
	public static let rational = ExifFormat(5)
	public static let sbyte = ExifFormat(6)
	public static let undefined = ExifFormat(7)
	public static let sshort = ExifFormat(8)
	public static let slong = ExifFormat(9)
	public static let srational = ExifFormat(10)
	public static let float = ExifFormat(11)
	public static let double = ExifFormat(12)

	public var description: String {
		switch self {
		case .byte:
			"exifFormatByte"
		case .ascii:
			"exifFormatAscii"
		case .short:
			"exifFormatShort"
		case .long:
			"exifFormatLong"
		case .rational:
			"exifFormatRational"
		case .sbyte:
			"exifFormatSbyte"
		case .undefined:
			"exifFormatUndefined"
		case .sshort:
			"exifFormatSshort"
		case .slong:
			"exifFormatSlong"
		case .srational:
			"exifFormatSrational"
		case .float:
			"exifFormatFloat"
		case .double:
			"exifFormatDouble"
		default:
			"exifFormatUnknown"
		}
	}

	var swiftType: Any.Type {
		switch self {
		case .byte: UInt.self
		case .ascii: String.self
		case .short: UInt16.self
		case .long: UInt64.self
		case .rational: Data.self
		case .sbyte: UInt16.self
		case .undefined: Data.self
		case .sshort: Int16.self
		case .slong: Int64.self
		case .srational: Data.self
		case .float: Float.self
		case .double: Double.self
		default: Data.self
		}
	}
}

extension ExifFormat: @retroactive Equatable {}
extension ExifFormat: @retroactive Hashable {}
