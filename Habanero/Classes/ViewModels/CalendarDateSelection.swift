import HorizonCalendar

// MARK: - CalendarDateSelection

/// A selection on a `CalendarView` specified as `Date` objects.
public enum CalendarDateSelection {
    /// A single date.
    case date(Date?)
    /// Multiple dates.
    case dates([Date])
    /// A date range.
    case dateRange(ClosedRange<Date>?)
    /// Multiple date ranges.
    case dateRanges([ClosedRange<Date>])
    /// No selection. View only.
    case none

    // MARK: Helpers

    func styleForDay(_ day: Day, calendar: Calendar) -> CalendarDayViewSelectionStyle {
        guard let date = day.date(calendar: calendar) else { return .none }

        switch self {
        case .date(let selectedDate):
            return (date == selectedDate) ? .singleSelect : .none
        case .dates(let selectedDates):
            return (selectedDates.contains(date)) ? .singleSelect : .none
        case .dateRange(let range):
            if let range = range {
                if (date == range.lowerBound) || (date == range.upperBound) {
                    return .activeRangeBoundary
                }
            }
        case .dateRanges(let ranges):
            for range in ranges {
                if (date == range.lowerBound) || (date == range.upperBound) {
                    return .inactiveRangeBoundary
                }
            }
            return .none
        case .none:
            return .none
        }

        return .none
    }
}
