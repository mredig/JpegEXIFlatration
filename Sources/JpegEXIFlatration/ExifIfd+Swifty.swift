import exif

extension ExifIfd: @retroactive CustomStringConvertible {
	public static let ifd0 = Self(0)
	public static let ifd1 = Self(1)
	public static let exif = Self(2)
	public static let gps = Self(3)
	public static let interoperability = Self(4)

	public var description: String {
		switch self {
		case .ifd0: "IFD 0"
		case .ifd1: "IFD 1"
		case .exif: "EXIF"
		case .gps: "GPS"
		case .interoperability: "Interoperability"
		default: "ExifIDF.Unknown"
		}
	}
}

extension ExifIfd: @retroactive Equatable {}
extension ExifIfd: @retroactive Hashable {}
