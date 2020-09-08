// MARK: - FooterLabel: FooterLabelDisplayable

public struct FooterLabel: FooterLabelDisplayable {

    // MARK: Properties

    public let text: String
    public let icon: Character?
    public let isTappable: Bool

    // MARK: Initializer

    public init(text: String, icon: Character?, isTappable: Bool) {
        self.text = text
        self.icon = icon
        self.isTappable = isTappable
    }

    public init(text: String) {
        self.text = text
        icon = nil
        isTappable = false
    }
}
