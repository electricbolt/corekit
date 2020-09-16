// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "CoreKit",
    products: [
        .library(name: "CoreKit", targets: ["CoreKit"]),
    ],
    targets: [
        .target(
            name: "CoreKit",
            path: "CoreKit"),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"],
            path: "CoreKitTests"),
    ]
)
