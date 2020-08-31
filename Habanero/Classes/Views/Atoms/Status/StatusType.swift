// MARK: - StatusType

/// Describes the state of something.
public enum StatusType {
    /// Selected status.
    case selected
    /// Alert status.
    case alert
    /// Normal status.
    case normal
    /// Success status.
    case success
    /// Warning status.
    case warning
    /// Inactive status.
    case inactive

    // MARK: Properties

    /// Returns the color to use for this `StatusType`.
    /// - Parameter colors: An object that defines all the colors for Habanero.
    /// - Returns: The color for this `StatusType`.
    public func color(colors: Colors) -> UIColor {
        switch self {
        case .alert: return colors.colorStatusAlert
        case .normal, .selected: return colors.colorStatusNormal
        case .success: return colors.colorStatusSuccess
        case .warning: return colors.colorStatusWarning
        case .inactive: return colors.colorStatusInactive
        }
    }

    /// Returns the text color to use for this `StatusType`.
    /// - Parameter colors: An object that defines all the colors for Habanero.
    /// - Returns: The text color for this `StatusType`.
    public func textColor(colors: Colors) -> UIColor {
        switch self {
        case .alert, .success: return .white
        default: return .surfaceBlack
        }
    }
}
