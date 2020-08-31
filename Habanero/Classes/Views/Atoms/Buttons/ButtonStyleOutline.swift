// MARK: - ButtonStyleOutline

/// A button style that displays text and a rounded border.
public enum ButtonStyleOutline {
    /// Primary style.
    case primary
    /// Secondary style 0 (neutral).
    case secondary0
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

    func borderColor(colors: Colors) -> UIColor {
        switch self {
        case .primary: return colors.borderButtonOutlinePrimary
        case .secondary0: return colors.borderButtonOutlineSecondary0
        case .secondary1: return colors.borderButtonOutlineSecondary1
        case .secondary2: return colors.borderButtonOutlineSecondary2
        case .secondary3: return colors.borderButtonOutlineSecondary3
        case .secondary4: return colors.borderButtonOutlineSecondary4
        case .secondary5: return colors.borderButtonOutlineSecondary5
        }
    }

    func textColor(colors: Colors) -> UIColor {
        switch self {
        case .primary: return colors.textButtonOutlinePrimary
        default: return colors.textButtonOutlineSecondary
        }
    }

    func textColorDisabled(colors: Colors) -> UIColor {
        return colors.textDisabled
    }

    // MARK: Style

    func styleEnabled(button: Button, colors: Colors, enabled: Bool) {
        button.layer.borderColor = (enabled ? borderColor(colors: colors) : colors.borderDisabled).cgColor
    }

    func styleSelected(button: Button, selected: Bool) {
        // underline
        let attributes: [NSAttributedString.Key: Any] = selected ? FontStyle.attributesUnderline() : [:]
        button.titleLabel?.attributedText = NSAttributedString(string: button.currentTitle ?? "",
                                                               attributes: attributes)

        // inner border
        button.customSubView?.isHidden = !selected
    }
}
