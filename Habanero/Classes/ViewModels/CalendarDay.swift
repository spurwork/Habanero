import HorizonCalendar

// MARK: - CalendarDay: CalendarDayViewDisplayable

struct CalendarDay: CalendarDayViewDisplayable {

    // MARK: Properties

    let day: Day
    let status: [CalendarDayStatus]
    let isHighlighted: Bool
    let selectionStyle: CalendarDayViewSelectionStyle
    let accessoryStyle: CalendarDayViewAccessoryStyle
}

// MARK: - CalendarDay: Equatable

extension CalendarDay: Equatable {
    static func == (lhs: CalendarDay, rhs: CalendarDay) -> Bool {
        return lhs.day == rhs.day
    }
}
