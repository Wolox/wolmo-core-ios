// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WolmoCore",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "WolmoCore",
            targets: ["WolmoCore"]),
    ],
    dependencies: [.package(url: "https://github.com/Quick/Quick.git",
                            from: "5.0.1"),
                   .package(url: "https://github.com/Quick/Nimble.git",
                            from: "10.0.0"),
                   .package(url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
                            .branch("main"))],
    targets: [
        .target(
            name: "WolmoCore",
            dependencies: [],
            path: "Sources/WolmoCore"),
        .testTarget(
            name: "WolmoCoreTests",
            dependencies: ["WolmoCore",
                           .product(name: "Quick", package: "Quick"),
                           .product(name: "Nimble", package: "Nimble"),
                           .product(name: "SnapshotTesting", package: "swift-snapshot-testing")],
            path: "WolmoCoreTests",
            exclude: ["Info.plist"],
            resources: [.copy("Localizable.strings")]),
    ]
)
