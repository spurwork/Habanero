// MARK: - RegexRule: Rule

public struct RegexRule: Rule {

    // MARK: Properties

    let regex: String

    // MARK: Initializer

    public init(regex: String) {
        self.regex = regex
    }

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: value) ? nil : ValidatorError.doesntMatchRegex(regex)
    }
}
