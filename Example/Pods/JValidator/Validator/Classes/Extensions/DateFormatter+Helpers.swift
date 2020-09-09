// MARK: - DateFormatter (Helpers)

public extension DateFormatter {
    /// Converts `String` into `Date` if it matches the specified `DateFormat`.
    /// - Parameters:
    ///   - string: The string to convert.
    ///   - dateFormat: The format expected for a successful conversion.
    /// - Returns: A `Date` if the conversion is successful. Otherwise, `nil` is returned.
    func date(from string: String, dateFormat: String) -> Date? {
        self.dateFormat = dateFormat
        return date(from: string)
    }

    /// Converts `Date` into `String` using the specified `DateFormat`.
    /// - Parameters:
    ///   - date: The date to convert.
    ///   - dateFormat: The format expected for the converted string.
    ///   - timeZone: An optional timezone. If provided, the converted string will be a date in this timezone.
    /// - Returns: A `String` representing a date with the specified `format` and, if provided, the `timeZone`.
    func string(from date: Date, dateFormat: String, timeZone: TimeZone? = nil) -> String {
        let previousTimezone = timeZone

        if let timeZone = timeZone { self.timeZone = timeZone }
        self.dateFormat = dateFormat

        let dateString = string(from: date)
        self.timeZone = previousTimezone

        return dateString
    }
}
