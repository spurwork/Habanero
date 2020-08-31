# Validator

## Contents

- `/Validator`: contains all source files and resources for Validator
- `/Example`: contains example iOS application that uses Validator  
- `Validator.podspec` : the CocoaPod specification for Validator

## Contributing

- clone the repo
- navigate to `/Example` and run `pod install` to let CocoaPods configure the example project
- make your changes!

## Releasing

1. (make changes, commit everything, test)
2. run `pod lib lint --allow-warnings`
3. if everything passes, bump the version in `Validator.podspec`
4. checkout `master`, commit/merge `develop` into `master`
5. create a tag for the new version
6. `git push && git push --tags`
7. push the CocoaPod to our private spec repo using `pod repo push --allow-warnings jarrodparkes Validator.podspec`
8. on GitHub, create a new release using the tag with the new semantic version
