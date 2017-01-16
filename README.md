# LTL

A simple LTL parser written in Swift.

# Example

```swift
let parsed = try! LTL.parse(fromString: "!F a")
print(parsed)                 // prints ! F a
print(parsed.nnf)             // prints G ! a
print(parsed.nnf.normalized)  // prints (false R ! a)
```

# Installation

## Swift Package Manager

```swift
.Package(url: "https://github.com/ltentrup/LTL.git", majorVersion: 0, minor: 1)
```
