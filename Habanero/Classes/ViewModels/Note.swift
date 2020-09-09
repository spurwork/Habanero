// MARK: - Note

/// An object that represents a textual observation.
public struct Note {

    // MARK: Properties

    let fontStyle: FontStyle
    let text: String
    let customTextColor: UIColor?
    let indentation: CGFloat

    let isTappable: Bool
    let backedValue: String?

    // MARK: Initializer

    /// Creates a `Note`.
    /// - Parameters:
    ///   - fontStyle: Font style.
    ///   - text: The note.
    ///   - customTextColor: A custom text color.
    ///   - indentation: Indentation.
    ///   - isTappable: Can the note be tapped?
    ///   - backedValue: An optional value to connect to the note.
    public init(fontStyle: FontStyle,
                text: String,
                customTextColor: UIColor? = nil,
                indentation: CGFloat = 0,
                isTappable: Bool = false,
                backedValue: String? = nil) {
        self.fontStyle = fontStyle
        self.text = text
        self.customTextColor = customTextColor
        self.indentation = indentation

        self.isTappable = isTappable
        self.backedValue = backedValue
    }

    /// Creates a `Note`.
    /// - Parameters:
    ///   - fontStyle: Font style.
    ///   - text: The note.
    public init(fontStyle: FontStyle, text: String) {
        self.fontStyle = fontStyle
        self.text = text
        customTextColor = nil
        indentation = 0

        isTappable = false
        backedValue = nil
    }
}
