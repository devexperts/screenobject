// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ScreenObject",
    products: [
        .library(
            name: "ScreenObject",
            targets: ["ScreenObject"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ScreenObject",
            dependencies: []),
        .testTarget(
            name: "ScreenObjectTests",
            dependencies: ["ScreenObject"])
    ]
)
