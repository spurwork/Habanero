// MARK: - Theme

/// An object that defines all the individual components contained within Habanero.
public protocol Theme {
    /// An object that defines all the colors for Habanero.
    var colors: Colors { get }

    /// An object that defines all the constants for Habanero.
    var constants: Constants { get }

    /// An object that defines all the images for Habanero.
    var images: Images { get }
}
