// MARK: - FooterModel: FooterDisplayable

public struct FooterModel: FooterDisplayable {

    // MARK: Properties

    public let buttonState: FooterButtonState
    public let content: FooterContent

    // MARK: Initializer

    public init(buttonState: FooterButtonState, content: FooterContent) {
        self.buttonState = buttonState
        self.content = content
    }

    public init(buttonState: FooterButtonState) {
        self.buttonState = buttonState
        content = .none
    }
}
