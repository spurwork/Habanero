// MARK: - RequiredRule: Rule

public struct RequiredRule: Rule {

    // MARK: Initializer

    public init() {}

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedValue.isEmpty ? ValidatorError.empty : nil
    }
}
