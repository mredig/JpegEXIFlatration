// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JpegEXIFlatration",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JpegEXIFlatration",
            targets: ["JpegEXIFlatration"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
		.systemLibrary(
			name: "C_EXIF",
			pkgConfig: "libexif",
			providers: [
				.apt(["libexif-dev"]),
				.brew(["libexif"])
			]),
		.systemLibrary(
			name: "C_IPTC",
			pkgConfig: "libiptcdata",
			providers: [
				.apt(["libiptcdata0-dev"]),
				.brew(["libiptcdata"])
			]),
        .target(
			name: "JpegEXIFlatration",
			dependencies: [
				"C_EXIF",
				"C_IPTC"
			]),
        .testTarget(
            name: "JpegEXIFlatrationTests",
            dependencies: ["JpegEXIFlatration"],
			resources: [
				.process("Resources")
			]),
    ]
)
