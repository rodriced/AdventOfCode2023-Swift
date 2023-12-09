// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AdventOfCode2023Swift",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.2.0")),
    ],
    targets: [
        .target(
            name: "AdventOfCode2023Swift",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            resources: [.copy("Inputs")]),
        .testTarget(
            name: "AdventOfCode2023SwiftTests",
            dependencies: ["AdventOfCode2023Swift"]),
    ]
)
