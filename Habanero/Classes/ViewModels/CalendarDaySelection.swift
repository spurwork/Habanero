import HorizonCalendar

// MARK: - CalendarDaySelection

/// A selection on a `CalendarView` specified as `Day` objects.
public enum CalendarDaySelection {
    /// A single day selection.
    case singleDay(Day?)
    /// A multi-day selection.
    case multiDay([Day])
    /// A single range selection.
    case singleRange(CalendarPartialDaySelection, ClosedRange<Day>?)
    /// A multi-range selection.
    case multiRange(CalendarPartialDaySelection, [ClosedRange<Day>])
    /// No selection. View only.
    case viewOnly

    var allowActiveRangeDeletion: Bool {
        if case let .multiRange(partial, _) = self, case .fullRange = partial {
            return true
        }

        return false
    }

    // MARK: Helpers

    func styleForDay(_ day: Day) -> CalendarDayViewSelectionStyle {
        switch self {
        case .singleDay(let selectedDay):
            return (day == selectedDay) ? .singleSelect : .none
        case .multiDay(let selectedDays):
            return (selectedDays.contains(day)) ? .singleSelect : .none
        case .singleRange(let partial, let selectedRange):
            if let selectedRange = selectedRange {
                if (day == selectedRange.lowerBound) || (day == selectedRange.upperBound) {
                    return .activeRangeBoundary
                }
            }
            return partial.styleForDay(day) ?? .none
        case .multiRange(let partial, let ranges):
            if let style = partial.styleForDay(day) {
                return style
            }

            for range in ranges {
                if (day == range.lowerBound) || (day == range.upperBound) {
                    return .inactiveRangeBoundary
                }
            }

            return .none
        case .viewOnly:
            return .none
        }
    }

    func allRanges(calendar: Calendar) -> Set<ClosedRange<Date>> {
        switch self {
        case .singleDay, .multiDay, .viewOnly:
            return []
        case .singleRange(_, let range):
            if let range = range, let dateRange = range.toDateRange(calendar: calendar) {
                return [dateRange]
            } else {
                return []
            }
        case .multiRange(_, let ranges):
            var allRanges = Set<ClosedRange<Date>>()
            for range in ranges {
                if let dateRate = range.toDateRange(calendar: calendar) {
                    allRanges.insert(dateRate)
                }
            }
            return allRanges
        }
    }

    func activeRange(calendar: Calendar) -> ClosedRange<Date>? {
        switch self {
        case .singleDay, .multiDay, .viewOnly:
            return nil
        case .singleRange(let partial, _), .multiRange(let partial, _):
            if case let .fullRange(range) = partial,
                let lowerBound = range.lowerBound.date(calendar: calendar),
                let upperBound = range.upperBound.date(calendar: calendar) {
                return lowerBound...upperBound
            } else {
                return nil
            }
        }
    }

    // MARK: Compute Next Selection

    func computeNextSelection(newlySelectedDay day: Day, calendar: Calendar) -> CalendarDaySelection {
        switch self {
        case .singleDay:
            return .singleDay(day)
        case .multiDay(let previouslySelectedDays):
            return computeNextMultipleDaysSelection(newlySelectedDay: day,
                                                    previouslySelectedDays: previouslySelectedDays)
        case .singleRange(let partial, _):
            return computeNextSingleRangeSelection(newlySelectedDay: day, partial: partial)
        case .multiRange(let partial, let ranges):
            return computeNextMultiRangeSelection(newlySelectedDay: day,
                                                  calendar: calendar,
                                                  partial: partial,
                                                  ranges: ranges)
        case .viewOnly:
            return .viewOnly
        }
    }

    private func computeNextMultipleDaysSelection(newlySelectedDay day: Day,
                                                  previouslySelectedDays: [Day]) -> CalendarDaySelection {
        if previouslySelectedDays.contains(day) {
            return .multiDay(previouslySelectedDays.filter { $0 != day })
        } else {
            return .multiDay(previouslySelectedDays + [day])
        }
    }

    private func computeNextSingleRangeSelection(newlySelectedDay day: Day,
                                                 partial: CalendarPartialDaySelection) -> CalendarDaySelection {
        switch partial {
        case .none:
            return .singleRange(.startRange(day), nil)
        case .fullRange:
            return .singleRange(.startRange(day), nil)
        case .startRange(let partialDay):
            let nextRange = computeNextRange(selectedDay: day, partialDay: partialDay)
            return .singleRange(.fullRange(nextRange), nextRange)
        }
    }

    private func computeNextMultiRangeSelection(newlySelectedDay day: Day,
                                                calendar: Calendar,
                                                partial: CalendarPartialDaySelection,
                                                ranges: [ClosedRange<Day>]) -> CalendarDaySelection {
        switch partial {
        case .none:
            if let range = dayInExistingRange(day, calendar: calendar, ranges: ranges) {
                return .multiRange(.fullRange(range), ranges)
            } else {
                return .multiRange(.startRange(day), ranges)
            }
        case .fullRange(let currentRange):
            if let date = day.date(calendar: calendar),
                let currentDateRange = currentRange.toDateRange(calendar: calendar) {
                if currentDateRange.contains(date) {
                    return .multiRange(.none, ranges)
                } else if let range = dayInExistingRange(day, calendar: calendar, ranges: ranges) {
                    return .multiRange(.fullRange(range), ranges)
                } else {
                    return .multiRange(.startRange(day), ranges)
                }
            } else {
                return .multiRange(.startRange(day), ranges)
            }
        case .startRange(let partialDay):
            var nextRange = computeNextRange(selectedDay: day, partialDay: partialDay)
            var mutableRanges = ranges

            while let index = findOverlap(nextRange: nextRange, ranges: mutableRanges, calendar: calendar) {
                let intersectingRange = mutableRanges.remove(at: index)
                let newLowerBound = min(nextRange.lowerBound, intersectingRange.lowerBound)
                let newUpperBound = max(nextRange.upperBound, intersectingRange.upperBound)
                nextRange = newLowerBound...newUpperBound
            }

            return .multiRange(.fullRange(nextRange), mutableRanges + [nextRange])
        }
    }

    private func computeNextRange(selectedDay day: Day, partialDay: Day) -> ClosedRange<Day> {
        if partialDay > day {
            return day...partialDay
        } else if partialDay == day {
            return day...day
        } else {
            return partialDay...day
        }
    }

    private func findOverlap(nextRange: ClosedRange<Day>, ranges: [ClosedRange<Day>], calendar: Calendar) -> Int? {
        guard let nextDateRange = nextRange.toDateRange(calendar: calendar) else { return nil }

        let dateRanges = ranges.compactMap { $0.toDateRange(calendar: calendar) }

        for (index, dateRange) in dateRanges.enumerated() {
            if nextDateRange.overlaps(dateRange) { return index }
        }
        return nil
    }

    private func dayInExistingRange(_ day: Day, calendar: Calendar, ranges: [ClosedRange<Day>]) -> ClosedRange<Day>? {
        for range in ranges {
            if let date = day.date(calendar: calendar),
                let dateRange = range.toDateRange(calendar: calendar),
                dateRange.contains(date) {
                return range
            }
        }
        return nil
    }
}

// MARK: - CalendarPartialDaySelection

/// A partial selection on a `CalendarView`.
public enum CalendarPartialDaySelection {
    /// A partial range selection consisting of one bound.
    case startRange(Day)
    /// A full range selection.
    case fullRange(ClosedRange<Day>)
    /// No selection.
    case none

    // MARK: Helpers

    func styleForDay(_ day: Day) -> CalendarDayViewSelectionStyle? {
        switch self {
        case .startRange(let partialDay):
            return (day == partialDay) ? .startRangeBoundary : nil
        case .fullRange(let range):
            return (day == range.lowerBound) || (day == range.upperBound) ? .activeRangeBoundary : nil
        default:
            return nil
        }
    }
}
