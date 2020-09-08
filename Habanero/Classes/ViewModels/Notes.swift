// MARK: - Notes: NotesViewDisplayable

public struct Notes: NotesViewDisplayable {

    // MARK: Properties

    public let notes: [Note]
    public let showBackground: Bool
    public let isContentInset: Bool
    public let customContentInsets: UIEdgeInsets?

    // MARK: Initializer

    public init(notes: [Note], showBackground: Bool, isContentInset: Bool, customContentInsets: UIEdgeInsets?) {
        self.notes = notes
        self.showBackground = showBackground
        self.isContentInset = isContentInset
        self.customContentInsets = customContentInsets
    }

    public init(notes: [Note]) {
        self.notes = notes
        self.showBackground = true
        self.isContentInset = true
        self.customContentInsets = nil
    }
}
