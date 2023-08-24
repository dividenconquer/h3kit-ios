// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "H3kit",
    products: [
        .library(
            name: "H3kit",
            targets: ["H3kit"]
        ),
    ],
    targets: [
        .target(
            name: "H3kitC",
            dependencies: [],
            path: "Sources/H3kitC",
            publicHeadersPath: "include"
        ),
        .target(
            name: "H3kit",
            dependencies: [
                .target(name: "H3kitC"),
            ],
            path: "Sources/Swift"
        ),
        .testTarget(
            name: "H3kitTests",
            dependencies: [
                .target(name: "H3kit"),
            ]
        ),
    ]
)
