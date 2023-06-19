// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Log",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .watchOS(.v4),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "Log",
            targets: ["Log"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Log",
            dependencies: []
        ),
        .testTarget(
            name: "LogTests",
            dependencies: ["Log"]
        )
    ]
)
