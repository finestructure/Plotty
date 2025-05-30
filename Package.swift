// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "Plotty",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "plotty", targets: ["Plotty"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    targets: [
        .executableTarget(name: "Plotty", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
        ]),
        .testTarget(name: "PlottyTests", dependencies: ["Plotty"])
    ]
)
