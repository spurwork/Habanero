// MARK: - DateRelationRule: Rule

public struct DateRelationRule: Rule {

    // MARK: Properties

    let referenceDateString: String
    let dateFormat: String
    let dateDisplayFormat: String

    let before: Bool
    let inclusive: Bool

    // MARK: Initializer

    public init(before referenceDateString: String, dateFormat: String, dateDisplayFormat: String) {
        self.referenceDateString = referenceDateString
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        inclusive = false
        before = true
    }

    public init(before date: Date, dateFormat: String, dateDisplayFormat: String) {
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        referenceDateString = Validator.shared.dateFormatter.string(from: date, dateFormat: dateFormat)
        inclusive = false
        before = true
    }

    public init(beforeOrEqualTo referenceDateString: String, dateFormat: String, dateDisplayFormat: String) {
        self.referenceDateString = referenceDateString
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        inclusive = true
        before = true
    }

    public init(beforeOrEqualTo date: Date, dateFormat: String, dateDisplayFormat: String) {
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        referenceDateString = Validator.shared.dateFormatter.string(from: date, dateFormat: dateFormat)
        inclusive = true
        before = true
    }

    public init(after referenceDateString: String, dateFormat: String, dateDisplayFormat: String) {
        self.referenceDateString = referenceDateString
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        inclusive = false
        before = false
    }

    public init(after date: Date, dateFormat: String, dateDisplayFormat: String) {
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        referenceDateString = Validator.shared.dateFormatter.string(from: date, dateFormat: dateFormat)
        inclusive = false
        before = false
    }

    public init(afterOrEqualTo referenceDateString: String, dateFormat: String, dateDisplayFormat: String) {
        self.referenceDateString = referenceDateString
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        inclusive = true
        before = false
    }

    public init(afterOrEqualTo date: Date, dateFormat: String, dateDisplayFormat: String) {
        self.dateFormat = dateFormat
        self.dateDisplayFormat = dateDisplayFormat

        referenceDateString = Validator.shared.dateFormatter.string(from: date, dateFormat: dateFormat)
        inclusive = true
        before = false
    }

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        if value == "" {
            return ValidatorError.dateInvalid
        } else {
            guard let valueAsDate = Validator.shared.dateFormatter.date(from: value,
                                                                       dateFormat: dateFormat),
                let referenceAsDate = Validator.shared.dateFormatter.date(from: referenceDateString,
                                                                         dateFormat: dateFormat)
                else { return ValidatorError.dateInvalid }

            if before && inclusive {
                return (valueAsDate <= referenceAsDate) ? nil
                    : ValidatorError.dateNotOlderThanOrEqualTo(referenceAsDate, dateDisplayFormat)
            } else if before && !inclusive {
                return (valueAsDate < referenceAsDate) ? nil
                    : ValidatorError.dateNotOlderThan(referenceAsDate, dateDisplayFormat)
            } else if !before && inclusive {
                return (valueAsDate >= referenceAsDate) ? nil
                    : ValidatorError.dateNotYoungerThanOrEqualTo(referenceAsDate, dateDisplayFormat)
            } else {
                return (valueAsDate > referenceAsDate) ? nil
                    : ValidatorError.dateNotYoungerThan(referenceAsDate, dateDisplayFormat)
            }
        }
    }
}

// MARK: - DateRelationRule (Common)

public extension DateRelationRule {
    /// A custom failable initializer for a `DateRelationRule` which checks if a date is "too old".
    /// - Parameters:
    ///   - years: The number of years the validated date string must be younger than.
    ///   - dateFormat: The format expected for the date string compared against this rule.
    init?(maximumAge years: Int, dateFormat: String, dateDisplayFormat: String) {
        if let yearsAgoDate = Calendar.current.date(byAdding: .year,
                                                    value: -years,
                                                    to: Date()) {
            self.dateFormat = dateFormat
            self.dateDisplayFormat = dateDisplayFormat

            referenceDateString = Validator.shared.dateFormatter.string(from: yearsAgoDate,
                                                                       dateFormat: dateFormat)
            inclusive = true
            before = false
        } else {
            return nil
        }
    }

    /// A custom failable initializer for a `DateRelationRule` which checks if a date is "too young".
    /// - Parameters:
    ///   - years: The number of years the validated date string must be older than.
    ///   - dateFormat: The format expected for the date string compared against this rule.
    init?(minimumAge years: Int, dateFormat: String, dateDisplayFormat: String) {
        if let yearsAgoDate = Calendar.current.date(byAdding: .year,
                                                    value: -years,
                                                    to: Date()) {
            self.dateFormat = dateFormat
            self.dateDisplayFormat = dateDisplayFormat

            referenceDateString = Validator.shared.dateFormatter.string(from: yearsAgoDate,
                                                                       dateFormat: dateFormat)
            inclusive = true
            before = true
        } else {
            return nil
        }
    }
}
