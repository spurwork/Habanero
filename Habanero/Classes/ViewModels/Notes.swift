// MARK: - Notes: NotesViewDisplayable

public struct Notes: NotesViewDisplayable {

    // MARK: Properties

    public let notes: [Note]
    public let showBackground: Bool
    public let isContentInset: Bool
    public let customContentInsets: UIEdgeInsets?
    public let customContentSpacing: CGFloat?

    // MARK: Initializer

    public init(notes: [Note],
                showBackground: Bool = true,
                isContentInset: Bool = true,
                customContentInsets: UIEdgeInsets? = nil,
                customContentSpacing: CGFloat? = nil) {
        self.notes = notes
        self.showBackground = showBackground
        self.isContentInset = isContentInset
        self.customContentInsets = customContentInsets
        self.customContentSpacing = customContentSpacing
    }

    public init(notes: [Note]) {
        self.notes = notes
        showBackground = true
        isContentInset = true
        customContentInsets = nil
        customContentSpacing = nil
    }
}
