# SwiftUI + TODO app

### Requirements
- Xcode 12+
- [Carthage](https://github.com/Carthage/Carthage) installed
- [Mint](https://github.com/yonaskolb/Mint#installing) installed

### Generate sample app

```
mint bootstrap
./carthage.sh bootstrap --platform ios --cache-builds
mint run xcodegen xcodegen generate
```