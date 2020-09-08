// MARK: - Notes: NotesViewDisplayable

public struct Notes: NotesViewDisplayable {

    // MARK: Properties

    public let notes: [Note]
    public let useBackground: Bool

    // MARK: Initializer

    public init(notes: [Note], useBackground: Bool = true) {
        self.notes = notes
        self.useBackground = useBackground
    }
}
