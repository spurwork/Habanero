// MARK: - Rule

/// A rule which can be applied against a string.
public protocol Rule {
    /// Validates a string value against some rule criteria and returns an `Error`, if encountered.
    /// - Parameter value: The string to validate.
    func validate(_ value: String) -> Error?
}
