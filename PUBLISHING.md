# Releasing — ios-signalseal-sdk

This repo is **public**. Customers add it to their Xcode projects via
Swift Package Manager or CocoaPods. It contains no real source — just a
`Package.swift` that resolves a precompiled xcframework from a GitHub
release asset produced by the sibling `ios-signalseal-core-sdk` repo.

## Release prerequisites

1. **The xcframework for this version must already be built** — from
   the private sibling:
   ```sh
   cd ../ios-signalseal-core-sdk
   ./scripts/build-xcframework.sh
   ```
2. Upload the produced
   `ios-signalseal-core-sdk/build/SignalSealAttributionSDK.xcframework.zip`
   as a GitHub release asset on THIS repo at the tag you're about to cut:
   ```
   https://github.com/signalseal/ios-signalseal-sdk/releases/download/v<semver>/SignalSealAttributionSDK.xcframework.zip
   ```
3. Note the SPM checksum the script printed — you'll paste it into
   `Package.swift`.

## Cutting a release

```sh
# In this repo
vim Package.swift
# Update .binaryTarget.url to the v<semver> release asset URL
# Update .binaryTarget.checksum to the sha256 printed by the builder
git add Package.swift
git commit -m "chore: bump to v<semver>"
git tag -a v<semver> -m "v<semver>"
git push origin main --tags
```

## Post-release verification

```sh
# From an empty test project:
swift package init --type executable
# Add the dependency:
#   .package(url: "https://github.com/signalseal/ios-signalseal-sdk", from: "<semver>")
swift package resolve
swift build
```

Resolution should succeed; build should link against the xcframework
without errors. If either fails, the most likely cause is a checksum
mismatch between `Package.swift` and the uploaded asset.

## CocoaPods

This repo can also be published to CocoaPods trunk (future work). When
ready:

1. Create a `SignalSealSDK.podspec` alongside `Package.swift` with
   `s.vendored_frameworks = "SignalSealAttributionSDK.xcframework"`
   pointing at the downloaded binary.
2. `pod lib lint SignalSealSDK.podspec --allow-warnings`
3. `pod trunk push SignalSealSDK.podspec`

## Do NOT

- Commit the `.xcframework.zip` into this repo — it lives on GitHub
  releases only (Swift Package Manager resolves via the URL)
- Manually edit anything outside `Package.swift` between releases
- Release here without running the private builder first — the checksum
  WILL mismatch
