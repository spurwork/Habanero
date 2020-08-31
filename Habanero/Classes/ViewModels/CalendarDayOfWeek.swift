import HorizonCalendar

// MARK: - CalendarMonthAndDayIndex

struct CalendarMonthAndDayIndex {

    // MARK: Properties

    let month: Month?
    let dayIndex: Int
}

// MARK: - CalendarMonthAndDayIndex: Equatable

extension CalendarMonthAndDayIndex: Equatable {
    static func == (lhs: CalendarMonthAndDayIndex, rhs: CalendarMonthAndDayIndex) -> Bool {
        if let lhsMonth = lhs.month, let rhsMonth = rhs.month {
            return lhsMonth == rhsMonth && lhs.dayIndex == rhs.dayIndex
        } else {
            return lhs.dayIndex == rhs.dayIndex
        }
    }
}
