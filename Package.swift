// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EasyNetwork",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "EasyNetwork",
            targets: ["EasyNetwork"]
        ),
        .library(
            name: "EasyURLSessionNetwork",
            targets: ["EasyURLSessionNetwork"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/EasyPackages/EasyMock.git",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/EasyPackages/EasyDate.git",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/EasyPackages/EasyTesting.git",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(name: "EasyNetwork", dependencies: ["EasyDate"]),
        .testTarget(
            name: "EasyNetworkTests",
            dependencies: ["EasyNetwork", "EasyMock", "EasyTesting"]
        ),
        
        .target(name: "EasyURLSessionNetwork", dependencies: ["EasyNetwork"]),
        .testTarget(
            name: "EasyURLSessionNetworkTests",
            dependencies: ["EasyURLSessionNetwork", "EasyMock", "EasyTesting"]
        ),
        
        .target(name: "EasyTesting", dependencies: ["EasyMock"]),
    ]
)
