// MARK: - FooterButtonPosition

/// Describes the location of a button within a `Footer`.
public enum FooterButtonPosition {
    /// Leftmost position.
    case left
    /// Center position.
    case center
    /// Rightmost position.
    case right
}

// MARK: - FooterButtonState

/// Describes the state of buttons within a `Footer`.
public enum FooterButtonState {
    /// No buttons shown.
    case none
    /// Two buttons shown. One on the left and right.
    case leftRight(String, String, ButtonStyleContained)
    /// A single button shown. Centered.
    case center(String, ButtonStyleContained)
}

// MARK: - FooterLabelDisplayable

/// An object that can be displayed by the label within a `Footer`.
public protocol FooterLabelDisplayable {
    /// The text for the footer's label.
    var text: String { get }

    /// An icon to append to the beginning of the footer's label.
    var icon: Character? { get }

    /// Can the footer's label be tapped?
    var isTappable: Bool { get }
}

// MARK: - FooterContent

/// Describes the (additional) content displayable within a `Footer`.
public enum FooterContent {
    /// No additional content.
    case none
    /// A label.
    case label(FooterLabelDisplayable)
    /// A checkbox with an optional (associated) backed value.
    case checkbox(SelectionControlDisplayable, Any?)
}
