// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TrixKit",
    products: [
        .library(
            name: "TrixKit",
            targets: ["TrixKit"]
        )
    ],
    targets: [
        .target(name: "TrixKit", dependencies: [], path: "TrixKit")
    ]
)