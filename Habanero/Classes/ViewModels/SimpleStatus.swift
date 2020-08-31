// MARK: - SimpleStatus: StatusViewDisplayable

public struct SimpleStatus: StatusViewDisplayable {

    // MARK: Properties

    public let status: String
    public let type: StatusType

    // MARK: Initializer

    public init(status: String, type: StatusType) {
        self.status = status
        self.type = type
    }
}
