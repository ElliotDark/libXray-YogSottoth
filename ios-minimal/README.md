# Minimal iOS Example

This folder contains a tiny SwiftUI application demonstrating how to use **libXray**.
It downloads a configuration file from a URL and starts Xray with that file.

To build the project:
1. Build `LibXray.xcframework` using `python3 build/main.py apple go`.
2. Add the framework and `XrayBridge.h` to a new Xcode project.
3. Include the files from the `App` and `Shared` folders.
