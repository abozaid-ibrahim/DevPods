// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

extension Target {
    static func devExtensions() -> Target {
        return .target(name: "DevExtensions", dependencies: [], path: "./DevExtensions", exclude: ["README.md", "DevPodsExample"])
    }

    static func devNetwork() -> Target {
        return .target(name: "DevNetwork", dependencies: [], path: "./DevNetwork", exclude: ["README.md", "DevPodsExample"])
    }

    static func devPlayer() -> Target {
        return .target(name: "DevPlayer", dependencies: [], path: "./DevPlayer", exclude: ["README.md", "DevPodsExample"])
    }

    static func devTag() -> Target {
        return .target(name: "DevTag", dependencies: [], path: "./DevTag", exclude: ["README.md", "DevPodsExample"])
    }

    static func devComponents() -> Target {
        return .target(name: "DevComponents", dependencies: [], path: "./DevComponents", exclude: ["README.md", "DevPodsExample"])
    }
}

let package = Package(
    name: "DevExtensions",
    platforms: [.iOS(.v11)],

    products: [
        .library(name: "DevExtensions", targets: ["DevExtensions"]),
        .library(name: "DevTag", targets: ["DevTag"]),
        .library(name: "DevComponents", targets: ["DevComponents"]),
    ],

    targets: [Target.devExtensions(), .devTag(), .devComponents()],
    swiftLanguageVersions: [.v5]
)
