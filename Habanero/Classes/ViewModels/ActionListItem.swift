// MARK: - ActionListItem: ActionListCellDisplayable

public struct ActionListItem: ActionListCellDisplayable {

    // MARK: Properties

    public let icon: UIImage?
    public let title: String
    public let subtitle: String?
    public let accessoryStyle: ActionListAccessoryViews

    public let customIconTintColor: UIColor?
    public let customTitleTextColor: UIColor?
    public let customBackgroundColor: UIColor?

    // MARK: Initializer

    public init(icon: UIImage?,
                title: String,
                subtitle: String?,
                accessoryStyle: ActionListAccessoryViews,
                customIconTintColor: UIColor? = nil,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.accessoryStyle = accessoryStyle
        self.customIconTintColor = customIconTintColor
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor
    }

    public init(title: String,
                subtitle: String?,
                accessoryStyle: ActionListAccessoryViews,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.accessoryStyle = accessoryStyle
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor

        self.icon = nil
        self.customIconTintColor = nil
    }

    public init(title: String,
                subtitle: String?,
                navigationStyle: ActionListNavigationStyle,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.accessoryStyle = .detailAndNavigation(nil, navigationStyle)
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor

        self.icon = nil
        self.customIconTintColor = nil
    }

    public init(icon: UIImage?,
                title: String,
                navigationStyle: ActionListNavigationStyle,
                customIconTintColor: UIColor? = nil,
                customTitleTextColor: UIColor? = nil,
                customBackgroundColor: UIColor? = nil) {
        self.icon = icon
        self.title = title
        self.accessoryStyle = .detailAndNavigation(nil, navigationStyle)
        self.customIconTintColor = customIconTintColor
        self.customTitleTextColor = customTitleTextColor
        self.customBackgroundColor = customBackgroundColor

        self.subtitle = nil
    }
}
