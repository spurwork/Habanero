// MARK: - AlertType

/// Describes a type of alert.
public enum AlertType {
    /// Error alert.
    case error
    /// Information alert.
    case info
    /// Success alert.
    case success

    // MARK: Properties

    /// Returns the color to use for this `AlertType`.
    /// - Parameter colors: An object that defines all the colors for Habanero.
    /// - Returns: The color for this `AlertType`.
    public func color(colors: Colors) -> UIColor {
        switch self {
        case .error: return colors.colorAlertError
        case .info: return colors.colorAlertInformation
        case .success: return colors.colorAlertSuccess
        }
    }

    /// Returns the icon to use for this `AlertType`.
    /// - Parameter images: An object that defines all the images for Habanero.
    /// - Returns: The icon for this `AlertType`.
    public func icon(images: Images) -> UIImage? {
        switch self {
        case .error: return images.closeCircle
        case .info: return images.info
        case .success: return images.checkCircle
        }
    }
}
