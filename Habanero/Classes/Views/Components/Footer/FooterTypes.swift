// MARK: - FooterButtonPosition

public enum FooterButtonPosition {
    case left
    case center
    case right
}

// MARK: - FooterButtonState

public enum FooterButtonState {
    case none
    case leftRight(String, String, ButtonStyleContained)
    case center(String, ButtonStyleContained)
}

// MARK: - FooterLabelDisplayable

public protocol FooterLabelDisplayable {
    /// The text for the label.
    var text: String { get }

    /// An icon to append to the beginning of the label.
    var icon: Character? { get }

    /// Can the label be tapped?
    var isTappable: Bool { get }
}

// MARK: - FooterContent

public enum FooterContent {
    case none
    case label(FooterLabelDisplayable)
    case checkbox(SelectionControlDisplayable, Any?)
}
