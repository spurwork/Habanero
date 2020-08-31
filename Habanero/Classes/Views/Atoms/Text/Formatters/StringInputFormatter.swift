// MARK: - StringInputFormatter: TextInputFormatter

public class StringInputFormatter: TextInputFormatter {

    // MARK: Properties

    private var textPattern: String = ""
    private var patternSymbol: Character = " "
    private var allowedSymbolsRegex: String = ""

    public static let shared = StringInputFormatter()

    // MARK: Initializer

    private init() {}

    // MARK: TextInputFormatter

    public func applyFormatToTextField(_ textField: UITextField,
                                       shouldChangeCharactersIn range: NSRange,
                                       textToAdd: String) {
        if let newContent = computeContent(currentText: textField.text,
                                           shouldChangeTextIn: range,
                                           replacementText: textToAdd) {
            textField.text = newContent.0
            correctCaretPosition(in: textField, originalRange: range, replacementFiltered: newContent.1)
        }
    }

    public func applyFormatToTextView(_ textView: UITextView,
                                      shouldChangeCharactersIn range: NSRange,
                                      textToAdd: String) {
        if let newContent = computeContent(currentText: textView.text,
                                           shouldChangeTextIn: range,
                                           replacementText: textToAdd) {
            textView.text = newContent.0
            correctCaretPosition(in: textView, originalRange: range, replacementFiltered: newContent.1)
        }
    }

    public func formatText(_ unformattedText: String?) -> String? {
        guard let unformattedText = unformattedText else { return nil }

        var formatted = ""
        var unformattedIndex = 0
        var patternIndex = 0

        while patternIndex < textPattern.count && unformattedIndex < unformattedText.count {
            guard let patternCharacter = textPattern.characterAt(patternIndex) else { break }
            if patternCharacter == patternSymbol {
                if let unformattedCharacter = unformattedText.characterAt(unformattedIndex) {
                    formatted.append(unformattedCharacter)
                }
                unformattedIndex += 1
            } else {
                formatted.append(patternCharacter)
            }
            patternIndex += 1
        }
        return formatted
    }

    public func unformatText(_ formattedText: String?) -> String? {
        guard let formattedText = formattedText else { return nil }

        var unformattedText = ""
        var formattedIndex = 0

        while formattedIndex < formattedText.count {
            if let formattedCharacter = formattedText.characterAt(formattedIndex) {
                if formattedIndex >= textPattern.count {
                    unformattedText.append(formattedCharacter)
                } else if formattedCharacter != textPattern.characterAt(formattedIndex) {
                    unformattedText.append(formattedCharacter)
                }
                formattedIndex += 1
            }
        }
        return unformattedText
    }

    // MARK: Helpers

    public func reset(textPattern: String, patternSymbol: Character, allowedSymbolsRegex: String) {
        self.textPattern = textPattern
        self.patternSymbol = patternSymbol
        self.allowedSymbolsRegex = allowedSymbolsRegex
    }

    // MARK: Helpers (github.com/luximetr/AnyFormatKit)

    private func computeContent(currentText: String?,
                                shouldChangeTextIn range: NSRange,
                                replacementText text: String) -> (String?, String)? {
        let replacementFiltered = text.filter(regex: allowedSymbolsRegex)
        let newContent = correctContent(currentContent: currentText,
                                        range: range,
                                        replacementFiltered: replacementFiltered)

        return (newContent, replacementFiltered)
    }

    private func correctContent(currentContent: String?, range: NSRange, replacementFiltered: String) -> String? {
        let oldText = currentContent ?? String()

        let correctedRange = unformatRange(range)
        let unformattedOldText = unformatText(oldText) as NSString?

        let newText = unformattedOldText?.replacingCharacters(in: correctedRange, with: replacementFiltered)
        return formatText(newText)
    }

    private func unformatRange(_ range: NSRange) -> NSRange {
        let newRange = NSRange(
            location: range.location - textPattern[..<textPattern.index(textPattern.startIndex,
                                                                        offsetBy: range.location)]
                .replacingOccurrences(of: String(patternSymbol), with: "").count,
            length: range.length - (textPattern as NSString).substring(with: range)
                .replacingOccurrences(of: String(patternSymbol), with: "").count)
        return newRange
    }

    private func correctCaretPosition(in textInput: UITextInput,
                                      originalRange range: NSRange,
                                      replacementFiltered: String) {
        var offset = 0
        if replacementFiltered.isEmpty {
            offset = offsetForRemove(current: range.location)
        } else {
            offset = offsetForInsert(from: range.location, replacementLength: replacementFiltered.count)
        }
        if let cursorLocation = textInput.position(from: textInput.beginningOfDocument,
                                                   offset: offset) {
            DispatchQueue.main.async {
                textInput.selectedTextRange = textInput.textRange(from: cursorLocation, to: cursorLocation)
            }
        }
    }

    private func offsetForRemove(current location: Int) -> Int {
        let startIndex = textPattern.startIndex
        let searchRange = startIndex..<textPattern.index(startIndex, offsetBy: location)
        let indexes = indexesOfPatternSymbols(in: searchRange)

        if let lastIndex = indexes.last {
            return lastIndex.utf16Offset(in: textPattern) + 1
        } else {
            return 0
        }
    }

    private func offsetForInsert(from location: Int, replacementLength: Int) -> Int {
        let startIndex = textPattern.index(textPattern.startIndex, offsetBy: location)
        let searchRange = startIndex..<textPattern.endIndex
        let indexes = indexesOfPatternSymbols(in: searchRange)

        if replacementLength <= indexes.count {
            return textPattern.distance(from: textPattern.startIndex, to: indexes[replacementLength - 1]) + 1
        } else {
            return textPattern.distance(from: textPattern.startIndex, to: textPattern.endIndex)
        }
    }

    private func indexesOfPatternSymbols(in searchRange: Range<String.Index>) -> [String.Index] {
        var indexes: [String.Index] = []
        var tempRange = searchRange

        while let range = textPattern.range(
            of: String(patternSymbol), options: .caseInsensitive, range: tempRange, locale: nil) {
                tempRange = range.upperBound..<tempRange.upperBound
                indexes.append(range.lowerBound)
        }

        return indexes
    }
}
