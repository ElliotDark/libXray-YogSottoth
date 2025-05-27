#!/usr/bin/env bash
# Build LibXray and the sample MVP application on macOS.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Step 1: Build LibXray xcframework
python3 "$REPO_ROOT/build/main.py" apple go

# Step 2: Build the Swift MVP example
pushd "$REPO_ROOT/ios-mvp/MvpApp" >/dev/null
swift build -c release
popd >/dev/null

echo "\nBuild completed. The executable can be found at ios-mvp/MvpApp/.build/release/MvpApp"

