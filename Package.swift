// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokerCard",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "PokerCard",
            targets: ["PokerCard"])
    ],
    targets: [
        .target(
            name: "PokerCard",
            path: "Sources")
    ]
)
