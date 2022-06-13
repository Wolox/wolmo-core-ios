// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wolmo-core-ios",
    products: [
        .library(
            name: "wolmo-core-ios",
            targets: ["wolmo-core-ios"]),
    ],
    dependencies: [],
    targets: [.target(
            name: "wolmo-core-ios",
            dependencies: []),
        .testTarget(
            name: "wolmo-core-iosTests",
            dependencies: ["wolmo-core-ios"]),
    ]
)
