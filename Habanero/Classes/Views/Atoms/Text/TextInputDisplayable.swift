// MARK: - UIKeyboardDisplayable

/// An object that can display a `UIKeyboard`.
public protocol UIKeyboardDisplayable {
    /// The type of keyboard to display.
    var keyboardType: UIKeyboardType { get }

    /// Defines the semantic meaning of the text being input.
    var textContentType: UITextContentType? { get }

    /// The auto-correction style to use while typing.
    var autocorrectionType: UITextAutocorrectionType { get }

    /// The auto-capitlization style to use while typing.
    var autocapitalizationType: UITextAutocapitalizationType { get }
}

// MARK: - TextInputDisplayable: UIKeyboardDisplayable

/// An object that can be displayed by a `TextInput`.
public protocol TextInputDisplayable: UIKeyboardDisplayable {
    /// The label to display for the `TextInput`.
    var label: String { get }

    /// The placeholder to display when the `TextInput` is empty.
    var placeholder: String? { get }

    /// An optional tip to display below the `TextInput`.
    var tip: String? { get }

    /// An optional tip to display behind a Help buton.
    var popoverHelpText: String? { get }

    /// Should the `TextInput` use a secure text entry mode?
    var useSecureTextEntry: Bool { get }

    /// An icon to display for the `TextInput`.
    var icon: UIImage? { get }

    /// Should this `TextInput` use a multiline control?
    var multiline: Bool { get }

    /// Should this `TextInput` show the number of characters entered into the `TextInput`?
    var showCharacterCount: Bool { get }

    /// An optional format that can be applied to the `TextInput` value as it is modified.
    var format: TextInputFormat? { get }

    /// Is this `TextInput` editable?
    var editable: Bool { get }

    /// The `TextInput` value. When empty, the placeholder is displayed, if provided.
    var value: String { get set }

    /// An error to display on the `TextInput`. If `nil`, then no error is displayed.
    var error: Error? { get set }

    /// Returns a custom amount of characters that can be entered into the `TextInput`. By default,
    /// Habanero defines a maximum amount of characters for multi and single-line `TextInput`.
    /// - Parameter constants: An object that defines all the constants for Habanero.
    func customCharacterCount(constants: Constants) -> UInt
}

// MARK: - TextInputDisplayable (Defaults)

public extension TextInputDisplayable {
    /// Returns a custom amount of characters that can be entered into this `TextInput`. By default,
    /// Habanero defines a maximum amount of characters for multi and single-line `TextInput`.
    /// - Parameter constants: An object that defines all the constants for Habanero.
    /// - Returns: The amount of characters that can be entered into this `TextInput`.
    func customCharacterCount(constants: Constants) -> UInt {
        return defaultCharacterCount(constants: constants)
    }

    /// Returns the default amount of characters that can be entered into a `TextInput`.
    /// - Parameter constants: An object that defines all the constants for Habanero.
    /// - Returns: The default amount of characters that can be entered into a `TextInput`.
    func defaultCharacterCount(constants: Constants) -> UInt {
        if let format = format {
            switch format {
            case .string(let textPattern, let patternSymbol, _):
                return UInt(textPattern.filter { $0 == patternSymbol }.count)
            case .dollars, .float:
                return NumberInputFormatter.shared.maxDigitsAllowed
            }
        }

        return multiline ? constants.textInputMaxCharactersMultiline : constants.textInputMaxCharacters
    }
}
