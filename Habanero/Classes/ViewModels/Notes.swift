// MARK: - Notes: NotesViewDisplayable

public struct Notes: NotesViewDisplayable {

    // MARK: Properties

    public let notes: [Note]

    // MARK: Initializer

    public init(notes: [Note]) {
        self.notes = notes
    }
}
