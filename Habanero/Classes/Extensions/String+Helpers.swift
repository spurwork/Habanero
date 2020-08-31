// MARK: - String (Helpers)

extension String {
    /// Convert a `String` to a stylized `NSAttributedString` using `FontStyle`.
    /// - Parameters:
    ///   - text: The text to display.
    ///   - fontStyle: The semantic font style to use.
    ///   - color: The text's color.
    ///   - alignment: The text's alignment.
    ///   - indentation: The spacing, in points, from the leading margin of label's text container.
    ///   - lineBreakMode: The mode to use when the text is too long to fits the label's text container.
    public func attributed(fontStyle: FontStyle,
                           color: UIColor,
                           alignment: NSTextAlignment = .left,
                           indentation: CGFloat = 0,
                           lineBreakMode: NSLineBreakMode? = nil,
                           additionalAttributes: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        let casedString = (fontStyle == .h6) ? self.uppercased() : self
        let attributes = fontStyle.attributesWith(textColor: color,
                                                  alignment: alignment,
                                                  indentation: indentation,
                                                  lineBreakMode: lineBreakMode,
                                                  additionalAttributes: additionalAttributes)
        return NSAttributedString(string: casedString, attributes: attributes)
    }

    /// Returns the `Character` located at `index`, if exists.
    /// - Parameter index: The position within the `String`, zero-indexed.
    /// - Returns: The `Character` located at `index`, if it exists. Returns `nil` otherwise.
    public func characterAt(_ index: Int) -> Character? {
        guard index < count else { return nil }
        return self[self.index(self.startIndex, offsetBy: index)]
    }

    /// Filters out any characters not matching the provided regular expression. For example,
    /// if the regular expression is "[0-9]", then "200: hello, world 12" becomes "20012".
    /// - Parameter regex: Regular expression used for matching.
    /// - Returns: A string with any matching characters removed.
    public func filter(regex: String?) -> String {
        guard let regex = regex else { return self }
        let regexPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let filteredCharacters = filter { (character) -> Bool in
            regexPredicate.evaluate(with: String(character))
        }
        return String(filteredCharacters)
    }

    /// Returns if this string matches a regular expression.
    /// - Parameter regex: Regular expression used for matching.
    /// - Returns: `true` if the string has a match, `false` otherwise.
    public func contains(regex: String) -> Bool {
        return !filter(regex: regex).isEmpty
    }
}
