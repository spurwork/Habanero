// MARK: - Validator

/// An object whose methods can be used to validate strings.
public struct Validator {

    // MARK: Properties

    /// The shared `Validator` instance.
    public static let shared = Validator()

    /// A formatter that can be used for creating new `Rule` that are related to dates.
    public let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()

    // MARK: Initializer

    private init() {}

    // MARK: Helpers

    /// Validates a string against a set of rules. The rules are checked linearly, and the function short-circuits
    /// as soon as an error is found.
    /// - Parameters:
    ///   - string: The string to be validated.
    ///   - rules: An array of rules to apply against the string. Order matters.
    /// - Returns: The first error encountered during validation. `nil` if no error is encountered.
    public func validateString(_ string: String, withRules rules: [Rule]) -> Error? {
        for rule in rules {
            if let firstError = rule.validate(string) {
                return firstError
            }
        }

        return nil
    }

    /// Validates multiple strings against their own unique set of rules at the same time. The rules are checked
    /// linearly for each string-to-rules pair. The first error that is found for each string-to-rules pair is
    /// returned in the final array, or `nil` if no error is encountered.
    ///
    /// **Note**: `strings.count` must equal `rules.count`, and the returned array will also have the same count
    /// as the input arrays.
    /// - Parameters:
    ///   - strings: An array of strings to be validated.
    ///   - rules: A 2D array where each entry is an array of rules to apply against the same-index string.
    /// - Returns: An array where each entry is the first error encountered during validation of the same-index string
    /// against its set of rules. If no error is encountered, then the entry in the final arrayf or that string
    /// will be `nil`.
    public func validateStrings(_ strings: [String], withRules rules: [[Rule]]) -> [Error?]? {
        guard strings.count == rules.count else { return nil }

        var errors: [Error?] = []

        for index in 0..<strings.count {
            errors.append(validateString(strings[index], withRules: rules[index]))
        }

        return errors
    }
}
