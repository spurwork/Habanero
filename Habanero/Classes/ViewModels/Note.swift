// MARK: - NoteConfig

/// Parameters describing how to configure a `Note`.
public enum NoteConfig {
    /// A note that specifies a font style, optional text color override, and optional indentation.
    case text(FontStyle, UIColor?, CGFloat?)
    /// A note that is tappable and provides an optional backed value.
    case link(Any?)
}

// MARK: - Note

/// An object that represents a textual observation.
public struct Note {

    // MARK: Properties

    let config: NoteConfig
    let text: String

    // MARK: Initializer

    /// Creates a `Note`.
    /// - Parameters:
    ///   - config: Describes how to assemble the note.
    ///   - text: The note.
    public init(config: NoteConfig, text: String) {
        self.config = config
        self.text = text
    }
}
