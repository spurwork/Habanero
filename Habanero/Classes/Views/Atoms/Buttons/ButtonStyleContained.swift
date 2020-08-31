// MARK: - ButtonStyleContained

/// A button style that displays text, an opaque background, and a rounded border.
public enum ButtonStyleContained {
    /// Primary style.
    case primary
    /// Secondary style 1.
    case secondary1
    /// Secondary style 2.
    case secondary2
    /// Secondary style 3.
    case secondary3
    /// Secondary style 4.
    case secondary4
    /// Secondary style 5.
    case secondary5

    // MARK: Helpers

    /// Returns the background color for this `ButtonStyleContained`.
    /// - Parameter colors: An object that defines all the colors for Habanero.
    /// - Returns: The background color used for this `ButtonStyleContained`.
    public func backgroundColor(colors: Colors) -> UIColor {
        switch self {
        case .primary: return colors.backgroundButtonContainedPrimary
        case .secondary1: return colors.backgroundButtonContainedSecondary1
        case .secondary2: return colors.backgroundButtonContainedSecondary2
        case .secondary3: return colors.backgroundButtonContainedSecondary3
        case .secondary4: return colors.backgroundButtonContainedSecondary4
        case .secondary5: return colors.backgroundButtonContainedSecondary5
        }
    }

    func createInnerBorderView(frame: CGRect, theme: Theme) -> UIView {
        let colors = theme.colors
        let constants = theme.constants

        let offset: CGFloat = constants.buttonContainedInnerBorderInset
        let padding = offset * 2.0
        let innerBorderView = UIView(frame: CGRect(x: offset,
                                                   y: offset,
                                                   width: frame.size.width - padding,
                                                   height: frame.size.height - padding))

        innerBorderView.backgroundColor = .clear
        innerBorderView.layer.borderWidth = constants.buttonBorderWidth
        innerBorderView.layer.borderColor = colors.borderButtonContained.cgColor
        innerBorderView.layer.cornerRadius = constants.buttonCornerRadiusStandard
        innerBorderView.isHidden = true

        return innerBorderView
    }

    func textColor(colors: Colors) -> UIColor {
        switch self {
        case .primary: return colors.textButtonContainedPrimary
        default: return colors.textButtonContainedSecondary
        }
    }

    // MARK: Style

    func styleEnabled(button: Button, colors: Colors, enabled: Bool) {
        button.backgroundColor = enabled ?
            backgroundColor(colors: colors) : colors.backgroundButtonContainedDisabled
    }

    func styleSelected(button: Button, colors: Colors, selected: Bool) {
        // underline
        let attributes: [NSAttributedString.Key: Any] = selected ? FontStyle.attributesUnderline() : [:]
        button.titleLabel?.attributedText = NSAttributedString(string: button.currentTitle ?? "",
                                                               attributes: attributes)

        // inner border
        button.customSubView?.isHidden = !selected
        button.customSubView?.layer.borderColor = colors.borderButtonContained.cgColor
    }
}
