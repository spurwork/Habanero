// MARK: - CalendarRange

struct CalendarRange {

    // MARK: Properties

    let frames: [CGRect]
    let color: UIColor
}

// MARK: - CalendarRange: Equatable

extension CalendarRange: Equatable {
    static func == (lhs: CalendarRange, rhs: CalendarRange) -> Bool {
        return lhs.frames == rhs.frames
    }
}
