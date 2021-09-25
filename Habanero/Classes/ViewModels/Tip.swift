// MARK: - Tip: TipViewDisplayable

public struct Tip: TipViewDisplayable {

    // MARK: Properties

    public let message: String
    public let duration: Double?
    public let anchor: AnchorPoint?

    // MARK: Initializer

    public init(message: String, duration: Double? = nil, anchor: AnchorPoint? = nil) {
        self.message = message
        self.duration = duration
        self.anchor = anchor
    }
}
