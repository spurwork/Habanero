// MARK: - Calendar (Helpers)

extension Calendar {
    /// Removes all time components from a `Date` so that only year, month, and day information is retained.
    /// - Parameter fromDate: The date to remove time components from.
    /// - Returns: A `Date` with time components removed.
    public func trimTimeFromDate(_ fromDate: Date) -> Date? {
        let components = dateComponents([.year, .month, .day], from: fromDate)
        return date(from: components)
    }

    /// Returns an array of `Date` objects from [`fromDate`, `toDate`].
    /// - Parameters:
    ///   - fromDate: The starting date.
    ///   - toDate: The ending date.
    /// - Returns: An array of `Date` objects.
    public func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []

        var date = fromDate
        while date <= toDate {
            dates.append(date)
            guard let newDate = self.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }

        return dates
    }
}
