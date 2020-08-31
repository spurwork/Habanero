// MARK: - TextInputFormat

/// A format specification for text.
public enum TextInputFormat {
    /// A string format that can specify a pattern and allowed symbols.
    case string(textPattern: String, patternSymbol: Character, allowedSymbolsRegex: String)
    /// A currency format.
    case dollars(maxDollars: Int64?, useCents: Bool)
    /// A floating (decimal) number format.
    case float(maxWholeNumber: Int64?)
}

// MARK: - TextInputFormatter

/// An object that can format text input.
public protocol TextInputFormatter: class {
    /// Mutating function that updates `UITextField.text` by applying a custom format.
    /// - Parameters:
    ///   - textField: The `UITextField` to modify.
    ///   - range: The characters that should be changed. Remember, text inputs can have multiple
    ///   characters selected when new text is being added.
    ///   - textToAppend: The text to add.
    func applyFormatToTextField(_ textField: UITextField,
                                shouldChangeCharactersIn range: NSRange,
                                textToAdd: String)

    /// Mutating function that updates `UITextView.text` by applying a custom format.
    /// - Parameters:
    ///   - textView: The `UITextView` to modify.
    ///   - range: The characters that should be changed. Remember, text inputs can have multiple
    ///   characters selected when new text is being added.
    ///   - textToAppend: The text to add.
    func applyFormatToTextView(_ textView: UITextView,
                               shouldChangeCharactersIn range: NSRange,
                               textToAdd: String)

    func formatText(_ unformattedText: String?) -> String?
    func unformatText(_ formattedText: String?) -> String?
}
