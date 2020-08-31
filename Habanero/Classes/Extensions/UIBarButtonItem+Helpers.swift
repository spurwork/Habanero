// MARK: - UIBarButtonItem (Helpers)

extension UIBarButtonItem {
    /// Creates a `UIBarButtonItem` with Habanero styling that contains a label.
    /// - Parameters:
    ///   - theme: The theme used for styling of the item.
    ///   - text: The text to display on the label.
    /// - Returns: A Habanero-styled `UIBarButtonItem` with a label.
    public static func createLabelItem(theme: Theme, text: String?) -> UIBarButtonItem {
        let colors = theme.colors
        let label = UILabel()
        let title = text ?? ""

        label.attributedText = title.attributed(fontStyle: .h5, color: colors.textHighEmphasis)
        label.sizeToFit()

        return UIBarButtonItem(customView: label)
    }

    /// Creates a `UIBarButtonItem` with Habanero styling that contains an image.
    /// - Parameters:
    ///   - theme: The theme used for styling of the item.
    ///   - image: The image to display on the button.
    ///   - target: The object which will receive the action when this button item is tapped.
    ///   - action: The action to send to the target when this button item is tapped.
    ///   - accessibilityIdentifier: An identifier for this button item that is used by screen readers and UI testing.
    /// - Returns: A Habanero-styled `UIBarButtonItem` with an image.
    public static func createImageButtonItem(theme: Theme,
                                             image: UIImage?,
                                             target: Any?,
                                             action: Selector?,
                                             accessibilityIdentifier: String) -> UIBarButtonItem {
        return createImageButtonNew(theme: theme,
                                    image: image,
                                    target: target,
                                    action: action,
                                    accessibilityIdentifier: accessibilityIdentifier)
    }

    private static func createImageButtonNew(theme: Theme,
                                             image: UIImage?,
                                             target: Any?,
                                             action: Selector?,
                                             accessibilityIdentifier: String) -> UIBarButtonItem {
        let colors = theme.colors
        let constants = theme.constants

        let button = UIButton(frame: .zero)
        button.backgroundColor = .clear
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = constants.barButtonItemImageEdgeInsets
        button.setImage(image, for: .normal)
        button.tintColor = colors.tintImageBarButtonItem
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        let barButtonItem = UIBarButtonItem(customView: button)

        let itemSize = constants.barButtonItemImageSize
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        if let heightConstraint = barButtonItem.customView?.heightAnchor.constraint(equalToConstant: itemSize.height),
            let widthConstraint = barButtonItem.customView?.widthAnchor.constraint(equalToConstant: itemSize.width) {
            NSLayoutConstraint.activate([heightConstraint, widthConstraint])
        }

        barButtonItem.accessibilityIdentifier = accessibilityIdentifier

        return barButtonItem
    }
}

// SOURCE: gist.github.com/freedom27/c709923b163e26405f62b799437243f4
extension UIBarButtonItem {
    /// Adds badge to `UIBarButtonItem`.
    /// - Parameters:
    ///   - theme: The theme used for styling of the badge.
    ///   - number: The number to apply to the badge. Anything over 9 is displayed at "9+".
    public func addBadge(theme: Theme, number: Int) {
        let constants = theme.constants

        addBadge(theme: theme,
                 number: number,
                 offset: constants.barButtonItemBadgeOffset,
                 knownWidth: constants.barButtonItemBadgeWidth)
    }

    /// Removes badge from `UIBarButtonItem`.
    public func removeBadge() {
        badgeLayer?.removeFromSuperlayer()
    }

    private struct AssociatedKey {
        static var badgeLayer = "badgeLayer"
    }

    private var badgeLayer: CAShapeLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.badgeLayer) as? CAShapeLayer
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKey.badgeLayer,
                    newValue as CAShapeLayer?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }

    private func addBadge(theme: Theme,
                          number: Int,
                          offset: CGPoint = CGPoint.zero,
                          knownWidth: CGFloat? = nil) {
        guard let view = self.value(forKey: "view") as? UIView else { return }

        let colors = theme.colors
        let constants = theme.constants

        // remove existing label, if exists
        badgeLayer?.removeFromSuperlayer()

        // initialize badge
        let badge = CAShapeLayer()
        let badgeCircleSize = constants.barButtonItemBadgeCircleSize
        let buttonWidth = knownWidth ?? view.frame.width
        let location = CGPoint(x: buttonWidth - (badgeCircleSize.width + offset.x),
                               y: (badgeCircleSize.height + offset.y))
        badge.drawCircleAtLocation(location: location,
                                   width: badgeCircleSize.width,
                                   height: badgeCircleSize.height,
                                   color: colors.backgroundButtonBarBadge)

        // only add the badge if the number is greater than 0
        if number > 0 {
            view.layer.addSublayer(badge)
        }

        // initialize label
        let labelSize = constants.barButtonItemBadgeLabelSize
        let label = CATextLayer()
        label.string = number > 9 ? "9+" : "\(number)"
        label.alignmentMode = CATextLayerAlignmentMode.center
        label.fontSize = constants.barButtonItemBadgeFontSize
        label.frame = CGRect(origin: CGPoint(x: location.x - (labelSize.width / 2),
                                             y: offset.y),
                             size: CGSize(width: labelSize.width,
                                          height: labelSize.height))
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)

        // save badge
        badgeLayer = badge
    }
}
