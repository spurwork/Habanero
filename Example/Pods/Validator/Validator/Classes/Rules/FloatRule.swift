// MARK: - FloatRule: Rule

public struct FloatRule: Rule {

    // MARK: Initializer

    public init() {}

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        let regex = try? NSRegularExpression(pattern: "^[-+]?(\\d*[.])?\\d+$", options: [])
        if let regex = regex {
            let match = regex.numberOfMatches(in: value,
                                              options: [],
                                              range: NSRange(location: 0, length: value.count))
            return match == 1 ? nil : ValidatorError.notFloat
        }
        return nil
    }
}
