// MARK: - CharacterSetRule: Rule

public struct CharacterSetRule: Rule {

    // MARK: Properties

    let characterSet: CharacterSet
    let inSet: Bool

    // MARK: Initializer

    public init(in characterSet: CharacterSet) {
        self.characterSet = characterSet
        inSet = true
    }

    public init(notIn characterSet: CharacterSet) {
        self.characterSet = characterSet.inverted
        inSet = false
    }

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        for scalar in value.unicodeScalars {
            guard let uniVal = UnicodeScalar(scalar.value), characterSet.contains(uniVal) else {
                return inSet ?
                    ValidatorError.elementNotInCharacterSet(characterSet) :
                    ValidatorError.elementInCharacterSet(characterSet)
            }
        }

        return nil
    }
}

// MARK: - CharacterSetRule (Common)

public extension CharacterSetRule {
    /// A character set rule checking for alpha-numeric characters.
    static var alphaNumeric: CharacterSetRule {
        return CharacterSetRule(in: .alphanumerics)
    }

    /// A character set rule checking for letters.
    static var lettersOnly: CharacterSetRule {
        return CharacterSetRule(in: .letters)
    }

    /// A character set rule checking for numbers.
    static var numbersOnly: CharacterSetRule {
        return CharacterSetRule(in: .decimalDigits)
    }
}
