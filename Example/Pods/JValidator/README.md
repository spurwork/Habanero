# Validator
A simple string validation library.

## Introduction
`Validator` is a library that can be used to validate a string against set of `Rule` objects:

```swift
public protocol Rule {        
    func validate(_ value: String) -> Error?
}
```

This simple test demonstrates `Validator`'s ease-of-use:

```swift
import JValidator

let validator = Validator.shared
let rules = [Rule] = [CharacterSetRule(in: lettersAndExtras), NoEmojiRule()]

XCTAssertNotNil(validator.validateString("abc😎", withRules: rules), "abc😎 is not a valid name")
XCTAssertNil(validator.validateString("jarrod", withRules: rules), "jarrod is a valid name")
```

If a string is invalid, then an `Error` is returned. Custom `ValidatorError`s are defined in `Validator` and can be mapped however you prefer.

## Installation
### CocoaPods
To install `Validator` using [CocoaPods](http://cocoapods.org), add `pod 'Validator'` to your Podfile, then follow the integration tutorial [here](https://guides.cocoapods.org/using/using-cocoapods.html).

## Contributions
`Validator` welcomes fixes, improvements, and feature additions. If you'd like to contribute, open a pull request with a detailed description of your changes.

As a rule of thumb, if you're proposing an API-breaking change or a change to existing functionality, consider proposing it by opening an issue, rather than a pull request; we'll use the issue as a public forum for discussing whether the proposal makes sense or not.

## Authors
Jarrod Parkes
- https://github.com/jarrodparkes

## Maintainers
Jarrod Parkes
- https://github.com/jarrodparkes

If you or your company has found `Validator` to be useful, let me know!

## License

`Validator` is released under the Apache License 2.0. See [LICENSE](LICENSE) for details.
