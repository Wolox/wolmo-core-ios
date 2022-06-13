// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WolmoCore",
    products: [
        .library(
            name: "WolmoCore",
            targets: ["WolmoCore"]),
    ],
    dependencies: [],
    targets: [.target(
            name: "WolmoCore",
            dependencies: [],
            path: "Sources/WolmoCore",
            exclude: ["AnimationDemoTests",
            "AnimationDemoUITests",
            "WolmoCoreDemo",
            "WolmoCoreTests",
            "WolmoCoreDemoTests"]),
        .testTarget(
            name: "WolmoCoreTests",
            dependencies: ["WolmoCore"],
            path: "WolmoCoreTests"),
    ]
)
