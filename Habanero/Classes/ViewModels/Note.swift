// MARK: - Note

/// An object that captures an observation to be listed.
public struct Note {

    // MARK: Properties

    let fontStyle: FontStyle
    let value: String

    let indentation: CGFloat
    let customTextColor: UIColor?
    let link: String?

    // MARK: Initializer

    /// Creates a `Note`.
    /// - Parameters:
    ///   - fontStyle: Font style.
    ///   - value: The note.
    ///   - indentation: Indentation.
    ///   - customTextColor: Custom text color to use.
    ///   - link: An optional link to connect to the note.
    public init(fontStyle: FontStyle,
                value: String,
                indentation: CGFloat = 0,
                customTextColor: UIColor? = nil,
                link: String? = nil) {
        self.fontStyle = fontStyle
        self.value = value
        self.indentation = indentation
        self.customTextColor = customTextColor
        self.link = link
    }

    /// Creates a `Note`.
    /// - Parameters:
    ///   - fontStyle: Font style.
    ///   - value: The note.
    public init(fontStyle: FontStyle, value: String) {
        self.fontStyle = fontStyle
        self.value = value

        indentation = 0
        customTextColor = nil
        link = nil
    }
}
