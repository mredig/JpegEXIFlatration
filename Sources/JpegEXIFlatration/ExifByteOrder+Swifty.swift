import exif

extension ExifByteOrder: @retroactive CustomStringConvertible {
	public static let motorola = EXIF_BYTE_ORDER_MOTOROLA
	public static let big = EXIF_BYTE_ORDER_MOTOROLA
	public static let intel = EXIF_BYTE_ORDER_INTEL
	public static let little = EXIF_BYTE_ORDER_INTEL

	public var description: String {
		switch self {
		case .big: "ExifByteOrder.big(Motorola)"
		case .little: "ExifByteOrder.little(Intel)"
		default: "ExifByteOrder.invalid"
		}
	}
}

extension ExifByteOrder: @retroactive Equatable {}
extension ExifByteOrder: @retroactive Hashable {}
