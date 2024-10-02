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

	public var asByte: UInt8? {
		rawData.first
	}

	private func toType<T>(from offset: Int = 0, _ type: T.Type = T.self) -> T? {
		let size = MemoryLayout<T>.size

		let startIndex = rawData.index(rawData.startIndex, offsetBy: offset)
		let endIndex = rawData.index(startIndex, offsetBy: size)

		let range = startIndex..<endIndex
		guard
			rawData.indices.contains(range)
		else { return nil }

		let section = rawData[range]

		return section.withUnsafeBytes { buffer in
			buffer.bindMemory(to: T.self).first
		}
	}

	public var asShort: UInt16? {
		guard
			let base: UInt16 = toType()
		else { return nil }

		if endianness == .little {
			return UInt16(littleEndian: base)
		} else {
			return UInt16(bigEndian: base)
		}
	}

	public var asLong: UInt32? {
		guard
			let base: UInt32 = toType()
		else { return nil }

		if endianness == .little {
			return UInt32(littleEndian: base)
		} else {
			return UInt32(bigEndian: base)
		}
	}

	public var asRational: RationalValue<UInt32>? {
		guard
			let baseNumerator: UInt32 = toType(),
			let baseDenominator: UInt32 = toType(from: MemoryLayout<UInt32>.size)
		else { return nil }

		if endianness == .little {
			let num = UInt32(littleEndian: baseNumerator)
			let den = UInt32(littleEndian: baseDenominator)
			return RationalValue(numerator: num, denominator: den)
		} else {
			let num = UInt32(bigEndian: baseNumerator)
			let den = UInt32(bigEndian: baseDenominator)
			return RationalValue(numerator: num, denominator: den)
		}
	}

	public var asUndefined: Data { rawData }

	public var asSbyte: Int8? { toType() }

	public var asSignedShort: Int16? {
		guard
			let base: Int16 = toType()
		else { return nil }

		if endianness == .little {
			return Int16(littleEndian: base)
		} else {
			return Int16(bigEndian: base)
		}
	}

	public var asSignedLong: Int32? {
		guard
			let base: Int32 = toType()
		else { return nil }

		if endianness == .little {
			return Int32(littleEndian: base)
		} else {
			return Int32(bigEndian: base)
		}
	}

	public var asSignedRational: RationalValue<Int32>?  {
		guard
			let baseNumerator: Int32 = toType(),
			let baseDenominator: Int32 = toType(from: MemoryLayout<Int32>.size)
		else { return nil }

		if endianness == .little {
			let num = Int32(littleEndian: baseNumerator)
			let den = Int32(littleEndian: baseDenominator)
			return RationalValue(numerator: num, denominator: den)
		} else {
			let num = Int32(bigEndian: baseNumerator)
			let den = Int32(bigEndian: baseDenominator)
			return RationalValue(numerator: num, denominator: den)
		}
	}

	public var asFloat: Float? {
		guard
			let base: UInt32 = toType()
		else { return nil }

		if endianness == .little {
			let floatBits = UInt32(littleEndian: base)
			return Float(bitPattern: floatBits)
		} else {
			let floatBits = UInt32(bigEndian: base)
			return Float(bitPattern: floatBits)
		}
	}

	public var asDouble: Double? {
		guard
			let base: UInt64 = toType()
		else { return nil }

		if endianness == .little {
			let floatBits = UInt64(littleEndian: base)
			return Double(bitPattern: floatBits)
		} else {
			let floatBits = UInt64(bigEndian: base)
			return Double(bitPattern: floatBits)
		}
	}
}

extension ExifRawData {
	public struct RationalValue<Num: BinaryInteger & Sendable & Codable & Hashable>: Sendable, Codable, Hashable {
		public var isValid: Bool { denominator != 0 }
		public let numerator: Num
		public let denominator: Num

		public var doubleValue: Double { Double(numerator) / Double(denominator) }

		public var evToShutterSpeed: Double {
			1 / exp2(doubleValue)
		}

		static private func greatestCommonDenominator(_ a: Num, b: Num) -> Num {
			b == 0 ? a : greatestCommonDenominator(b, b: a % b)
		}

		public func reduced() -> Self {
			guard
				isValid
			else { return self }

			let divisor = Self.greatestCommonDenominator(numerator, b: denominator)
			guard divisor != 1 else { return self }
			return Self(numerator: numerator / divisor, denominator: denominator / divisor)
		}

		public init(numerator: Num, denominator: Num) {
			self.numerator = numerator
			self.denominator = denominator
		}
	}
}
