// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AdventOfCode2023Swift",
    targets: [
        .target(
            name: "AdventOfCode2023Swift",
            resources: [.copy("Inputs")]),
        .testTarget(
            name: "AdventOfCode2023SwiftTests",
            dependencies: ["AdventOfCode2023Swift"]),
    ]
)
