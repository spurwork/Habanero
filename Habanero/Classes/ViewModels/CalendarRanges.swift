// MARK: - CalendarRanges

struct CalendarRanges {

    // MARK: Properties

    let ranges: [CalendarRange]
}

// MARK: - CalendarRanges: Equatable

extension CalendarRanges: Equatable {
    static func == (lhs: CalendarRanges, rhs: CalendarRanges) -> Bool {
        return lhs.ranges == rhs.ranges
    }
}
