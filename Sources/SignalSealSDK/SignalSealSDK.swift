// SignalSealSDK — thin public wrapper.
//
// Everything is implemented in the private `SignalSealAttributionSDK`
// module (shipped as a precompiled xcframework via binaryTarget). This
// file re-exports it so consumers can write `import SignalSealSDK`
// instead of leaking the internal module name.
//
// Do not add code here. Public API changes belong in the private core.

@_exported import SignalSealAttributionSDK
