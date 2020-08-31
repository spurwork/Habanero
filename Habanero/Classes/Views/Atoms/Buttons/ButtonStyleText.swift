// MARK: - ButtonStyleText

/// A button style that displays text similar to a label.
public enum ButtonStyleText {
    /// Primary style.
    case primary
    /// Secondary style.
    case secondary

    // MARK: Helpers

    func textColor(colors: Colors) -> UIColor {
        switch self {
        case .primary: return colors.textButtonTextPrimary
        case .secondary: return colors.textButtonTextSecondary
        }
    }

    // MARK: Style

    func styleSelected(button: Button, selected: Bool) {
        // underline
        let attributes: [NSAttributedString.Key: Any] = selected ? FontStyle.attributesUnderline() : [:]
        button.titleLabel?.attributedText = NSAttributedString(string: button.currentTitle ?? "",
                                                               attributes: attributes)
    }
}
