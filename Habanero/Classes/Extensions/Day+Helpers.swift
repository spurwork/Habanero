import HorizonCalendar

// MARK: - Day (Helpers)

extension Day {
    func date(calendar: Calendar) -> Date? {
        if let date = calendar.date(from: components) {
            return calendar.trimTimeFromDate(date)
        }
        return nil
    }
}

// MARK: - Day (Range Helpers)

extension ClosedRange where Bound == Day {
    func toDateRange(calendar: Calendar) -> ClosedRange<Date>? {
        if let lowerBound = lowerBound.date(calendar: calendar),
            let upperBound = upperBound.date(calendar: calendar) {
            return lowerBound...upperBound
        } else {
            return nil
        }
    }
}
