// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "MvpApp",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "MvpApp", targets: ["MvpApp"])
    ],
    targets: [
        .binaryTarget(
            name: "LibXray",
            path: "../../LibXray.xcframework"
        ),
        .target(
            name: "CBridge",
            dependencies: ["LibXray"],
            path: "CBridge",
            publicHeadersPath: "include"
        ),
        .executableTarget(
            name: "MvpApp",
            dependencies: ["CBridge"],
            path: "Sources/MvpApp",
            linkerSettings: [
                .linkedFramework("NetworkExtension")
            ]
        )
    ]
)
