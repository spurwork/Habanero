// MARK: - DateRule: Rule

public struct DateRule: Rule {

    // MARK: Properties

    let dateFormat: String

    // MARK: Initializer

    public init(dateFormat: String) {
        self.dateFormat = dateFormat
    }

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        if value == "" {
            return ValidatorError.dateInvalid
        } else {
            let date = Validator.shared.dateFormatter.date(from: value, dateFormat: dateFormat)
            return (date == nil) ? ValidatorError.dateInvalid : nil
        }
    }
}
