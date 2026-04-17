# SignalSeal iOS SDK

Mobile attribution SDK for iOS 15+. Ships as a precompiled xcframework
via Swift Package Manager.

## Install

Xcode → File → Add Package Dependencies… → paste:

```
https://github.com/signalseal/ios-signalseal-sdk
```

…and select the `SignalSealSDK` library product.

Or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/signalseal/ios-signalseal-sdk", from: "0.0.2")
]
```

## Usage

```swift
import SignalSealSDK

SignalSealSDK.shared.configure(
    apiKey: "ak_ios_01J8...",     // from signalseal.net dashboard
    isDebug: false
)

SignalSealSDK.shared.sendEvent(event: .purchase, parameters: [
    "revenue": 9.99,
    "currency": "USD"
])
```

## Permissions / Info.plist

If you want background flushing of the event queue, add to Info.plist:

```xml
<key>BGTaskSchedulerPermittedIdentifiers</key>
<array>
    <string>net.signalseal.sdk.flush</string>
</array>
```

## Repo layout

This directory (`ios-signalseal-sdk/`) is the **public** package — thin
wrapper that pulls down the compiled xcframework. The Swift source for
the framework lives in `../ios-signalseal-core-sdk/`; see its README
for build instructions.
