// MARK: - Alert: AlertViewDisplayable

public struct Alert: AlertViewDisplayable {

    // MARK: Properties

    public let type: AlertType
    public let message: String
    public let duration: Double
    public let anchor: AnchorPoint

    // MARK: Initializer

    public init(type: AlertType, message: String, duration: Double, anchor: AnchorPoint) {
        self.type = type
        self.message = message
        self.duration = duration
        self.anchor = anchor
    }
}
