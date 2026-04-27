// swift-tools-version:5.9
import PackageDescription

// SignalSeal iOS SDK — PUBLIC package. This is what app developers add to
// their Xcode projects:
//
//     .package(url: "https://github.com/signalseal/ios-signalseal-sdk", from: "0.0.14")
//
// The manifest pulls down a precompiled `SignalSealAttributionSDK.xcframework`
// as a binary target, then re-exports its public API through the
// `SignalSealSDK` module so consumers only ever `import SignalSealSDK`.
//
// The source for the binary lives in ../ios-signalseal-core-sdk/ and is
// compiled via scripts/build-xcframework.sh (see its scripts/).
let package = Package(
    name: "SignalSealSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SignalSealSDK",
            targets: ["SignalSealSDK"]
        )
    ],
    targets: [
        // Precompiled binary of the private core. Hosted as a release
        // asset on GitHub for each vX.Y.Z tag. Checksum below
        // corresponds to the xcframework built from ../ios-signalseal-core-sdk/ via
        //     cd ../ios-signalseal-core-sdk && ./scripts/build-xcframework.sh
        // Re-run that script + replace the checksum on every release.
        .binaryTarget(
            name: "SignalSealAttributionSDK",
            url: "https://github.com/signalseal/ios-signalseal-sdk/releases/download/v0.0.14/SignalSealAttributionSDK.xcframework.zip",
            checksum: "a46922d677b4b8a1d1127761a9a801bdc1f6c08de132756910e609f982ebaf0b"
        ),
        // Thin public target that re-exports the private module so apps can
        // just write `import SignalSealSDK`. No logic lives here.
        .target(
            name: "SignalSealSDK",
            dependencies: ["SignalSealAttributionSDK"],
            path: "Sources/SignalSealSDK"
        )
    ]
)
