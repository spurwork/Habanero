// MARK: - FontStyle: String

public enum FontStyle: String {
    case h1 = "H1"
    case h2 = "H2"
    case h3 = "H3"
    case h4 = "H4"
    case h5 = "H5"
    case h6 = "H6"
    case buttonText = "Button Text"
    case labelLarge = "Label Large"
    case labelSmall = "Label Small"
    case bodyLarge = "Body Large"
    case bodySmall = "Body Small"

    // MARK: Properties

    public var font: UIFont {
        return UIFont.systemFont(ofSize: sketchFontSize, weight: weight)
    }

    public var letterSpacing: CGFloat {
        switch self {
        case .h1: return 0.25
        case .h2, .h3,
             .buttonText, .labelLarge, .bodyLarge: return 0.0
        case .h4, .h5: return -0.4
        case .h6: return -0.29
        case .labelSmall: return -0.35
        case .bodySmall: return -0.36
        }
    }

    var lineBreakMode: NSLineBreakMode {
        return .byWordWrapping
    }

    var lineHeight: CGFloat { return sketchLineHeight / sketchFontSize }

    private var weight: UIFont.Weight {
        switch self {
        case .h1, .h2, .h3, .h5,
             .buttonText, .labelLarge, .labelSmall: return .medium
        case .h4, .bodyLarge, .bodySmall: return .regular
        case .h6: return .bold
        }
    }

    public var sketchLineHeight: CGFloat {
        switch self {
        case .h1: return 37
        case .h2: return 32
        case .h3: return 26
        case .h4: return 21
        case .h5: return 19
        case .h6: return 14
        case .buttonText: return 44
        case .labelLarge: return 16
        case .labelSmall: return 14
        case .bodyLarge: return 16
        case .bodySmall: return 12
        }
    }

    public var sketchFontSize: CGFloat {
        switch self {
        case .h1: return 28
        case .h2: return 24
        case .h3: return 20
        case .h4: return 16
        case .h5: return 14
        case .h6: return 10
        case .buttonText: return 16
        case .labelLarge: return 14
        case .labelSmall: return 12
        case .bodyLarge: return 12
        case .bodySmall: return 10
        }
    }

    // MARK: Helpers

    public func attributesWith(
        textColor: UIColor,
        alignment: NSTextAlignment = .left,
        indentation: CGFloat = 0,
        lineBreakMode customLineBreakMode: NSLineBreakMode? = nil,
        additionalAttributes: [NSAttributedString.Key: Any] = [:]) -> [NSAttributedString.Key: Any] {

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = customLineBreakMode ?? lineBreakMode
        paragraphStyle.lineSpacing = lineHeight
        paragraphStyle.alignment = alignment
        paragraphStyle.firstLineHeadIndent = indentation
        paragraphStyle.headIndent = indentation

        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.kern] = letterSpacing
        attributes[NSAttributedString.Key.font] = font

        for attribute in additionalAttributes {
            attributes[attribute.key] = attribute.value
        }

        return attributes
    }

    /// Returns a set of attributes which will underline attributed text.
    /// - Returns: Set of attributes for underlining attributed text.
    public static func attributesUnderline() -> [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
    }
}
