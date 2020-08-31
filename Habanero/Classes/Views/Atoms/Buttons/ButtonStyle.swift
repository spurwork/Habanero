// MARK: - ButtonStyle

/// A type of styling that can be applied to a `Button`.
public enum ButtonStyle {
    /// A button style that displays text, an opaque background, and a rounded border.
    case contained(ButtonStyleContained)
    /// A button style that displays a menu's selection or placeholder value.
    case menu
    /// A button style that displays text and a rounded border.
    case outline(ButtonStyleOutline)
    /// A button style that displays text similar to a label and specifies the content's horizontal layout.
    case text(ButtonStyleText, UIControl.ContentHorizontalAlignment)
}
