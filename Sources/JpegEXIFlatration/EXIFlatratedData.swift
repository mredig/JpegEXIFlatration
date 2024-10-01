import exif

public class EXIFlatratedData: CustomStringConvertible {
	public package(set) var dictionary: [ExifIfd: [String: String]] = [:]

	public var description: String {
		let sorted = dictionary.sorted(by: { $0.key.rawValue < $1.key.rawValue })

		var groups: [String] = []
		for idfGroup in sorted {
			let idf = idfGroup.key
			let sortedGroup = idfGroup
				.value
				.sorted(by: { $0.key < $1.key })
				.map { "\t\($0.key): \($0.value)" }
			groups.append("\(idf):\n\(sortedGroup.joined(separator: "\n"))")
		}
		return groups.joined(separator: "\n")
	}

	public init() {}

	package static func from(pointer: UnsafeMutableRawPointer) -> EXIFlatratedData {
		let typed = pointer.bindMemory(to: EXIFlatratedData.self, capacity: 1)
		return typed.pointee
	}

	package var pointer: UnsafeMutableRawPointer {
		let typedPointer = UnsafeMutablePointer<EXIFlatratedData>.allocate(capacity: 1)
		typedPointer.pointee = self
		let rawPointer = UnsafeMutableRawPointer(typedPointer)

		return rawPointer
	}
}
