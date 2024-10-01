import exif

extension ExifIfd: @retroactive CustomStringConvertible {
	public var description: String {
		switch self.rawValue {
		case 0:
			"IFD 0"
		case 1:
			"IFD 1"
		case 2:
			"EXIF"
		case 3:
			"GPS"
		case 4:
			"Interoperability"
		default:
			"ExifIDF.Unknown"
		}
	}
}

extension ExifIfd: @retroactive Equatable {}
extension ExifIfd: @retroactive Hashable {}
