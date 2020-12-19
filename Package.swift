// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
//
//extension Target {
//  static func devExtensions() -> [Target] {
//      return [.target(name: "DevExtensions", dependencies: [],path: "./DevExtensions", exclude: ["README.md"])]
//  }
//
//  static func devNetwork() -> [Target] {
//    return  [.target(name: "DevNetwork", dependencies: ["DevExtensions"],path: "./DevNetwork", exclude: ["README.md"])]
//  }
//
//
//}
//
//let package = Package(
//  name: "DevExtensions",
//  products: ([
//      .library(name: "DevExtensions", targets: ["DevExtensions"]),
//      .library(name: "DevNetwork", targets: ["DevNetwork"])] as [Product]),
//  targets: ([Target.devExtensions(),Target.devNetwork()] as [[Target]]).flatMap { $0 },
//  swiftLanguageVersions: [.v5]
//)
//

let package = Package(
    name: "DevNetwork",
    platforms: [.iOS(.v11)],
    
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DevNetwork",
            targets: ["DevNetwork"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [

        .target(
            name: "DevNetwork",
            dependencies: [],
            path: "./DevNetwork",
            exclude: ["Info.plist"]),
        
//        .testTarget(
//            name: "DevNetworkTests",
//            dependencies: ["DevDetwork"],
//            path: "./DevNetwork"),
    ],
    
    swiftLanguageVersions: [.v5]
    
)
