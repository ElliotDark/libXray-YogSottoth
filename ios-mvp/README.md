# libXray iOS MVP

This folder contains a very small example of how to use `libXray` in an iOS
project. The goal is to replicate Outline's behaviour using the wrapper
functions provided by this repository.

## Building `LibXray.xcframework`

1. Install Go and Xcode command line tools.
2. Run the build script from the repository root:

```bash
python3 build/main.py apple go
```

This repository also provides a convenience script that builds the framework and
compiles a tiny command line example on macOS:

```bash
./build_macos.sh
```

This will create `LibXray.xcframework` along with C header files inside the
`build/apple` directory. Because the framework does not contain a
`module.modulemap`, Swift projects need a bridging header.

## Integrating in Xcode

1. Add `LibXray.xcframework` to your Xcode project.
2. Create a bridging header and include `XrayBridge.h` from this folder.
3. Add the `PacketTunnelProvider.swift` file to a Network Extension target and
   use `ContentView.swift` for a very simple UI in the main app target.
4. Provide two keys in `providerConfiguration` when starting the tunnel:
   `datDir` (path to geodata) and `configPath` (path to the Xray JSON config).

With these pieces in place you can call `CGoRunXray` and `CGoStopXray` from your
Swift code to manage the VPN tunnel.
