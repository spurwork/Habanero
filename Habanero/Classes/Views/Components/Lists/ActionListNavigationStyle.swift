// MARK: - ActionListNavigationStyle

/// Describes a style based on the navigation icon to apply to an action list cell.
public enum ActionListNavigationStyle {
    /// A style for items that navigate away from the app.
    case external
    /// A style for items that do not navigate.
    case none
    /// A style for items that navigate by (modally) presenting a new screen.
    case present
    /// A style for items that navigate by pushing a new screen into focus.
    case push
    /// A style for items that navigate to the app's screen.
    case settings

    /// Returns the icon associated with this navigation style.
    /// - Parameter images: An object that defines all the images for Habanero.
    /// - Returns: An icon for this navigation style.
    public func icon(images: Images) -> UIImage? {
        switch self {
        case .external: return images.logout
        case .none: return images.empty
        case .present: return images.caretUp
        case .push: return images.caretRight
        case .settings: return images.gear
        }
    }
}
