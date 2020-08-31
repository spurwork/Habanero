// MARK: - ThemeStandard: Theme, Bundlable

public struct ThemeStandard: Theme, Bundlable {

    // MARK: Properties

    public let colors: Colors = ColorsStandard()
    public let constants: Constants = ConstantsStandard()
    public let images: Images = ImagesStandard()

    // MARK: Initializer

    public init () {}

    // MARK: Helpers

    public static func loadFonts() {
        return
    }
}
