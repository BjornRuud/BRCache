// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BRCache",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "BRCache",
            targets: ["BRCache"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BRCache",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "BRCacheTests",
            dependencies: ["BRCache"]),
    ],
    swiftLanguageVersions: [.v5]
)
