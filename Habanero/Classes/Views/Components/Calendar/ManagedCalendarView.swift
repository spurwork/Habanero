import HorizonCalendar

// MARK: - ManagedCalendarViewDelegate

protocol ManagedCalendarViewDelegate: class {
    func managedCalendarViewTriedOverscroll(_ managedCalendarView: ManagedCalendarView)
    func managedCalendarViewSelectionDidChange(_ managedCalendarView: ManagedCalendarView,
                                               selection: CalendarDaySelection,
                                               selectedDates: [Date])
}

// MARK: - ManagedCalendarView

class ManagedCalendarView {

    // MARK: Properties

    var calendarView: HorizonCalendar.CalendarView!

    weak var delegate: ManagedCalendarViewDelegate?

    private let theme: Theme
    private let width: CGFloat
    private let config: CalendarViewConfig

    private var selection: CalendarDaySelection {
        didSet {
            selectedDates = computeSelectedDates(calendar: calendar)
        }
    }
    private var selectedDates: [Date] = []

    private var datesToStatus: [Date: [CalendarDayStatus]]
    private var highlightedDates: [Date] = []

    private var calendar = Calendar(identifier: .gregorian)
    private var todayComponents = DateComponents()
    private var isDirty = false

    var minVisibleDate: Date? {
        if let day = calendarView.visibleDayRange?.lowerBound {
            return calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))
        }
        return nil
    }

    var maxVisibleDate: Date? {
        if let day = calendarView.visibleDayRange?.upperBound {
            return calendar.date(from: DateComponents(year: day.month.year, month: day.month.month, day: day.day))
        }
        return nil
    }

    // MARK: Initializer

    init(theme: Theme,
         width: CGFloat,
         config: CalendarViewConfig) {
        self.theme = theme
        self.width = width
        self.config = config

        switch config.initialDateSelection {
        case .date: selection = .singleDay(nil)
        case .dates: selection = .multiDay([])
        case .dateRange: selection = .singleRange(.none, nil)
        case .dateRanges: selection = .multiRange(.none, [])
        case .none: selection = .viewOnly
        }

        calendar.locale = Locale.current
        datesToStatus = [:]
    }

    // MARK: Calendar Content

    func initContent() {
        calendarView = HorizonCalendar.CalendarView(initialContent: makeContent())
        calendarView.directionalLayoutMargins = theme.constants.calendarViewDirectionalLayoutMargins
        calendarView.daySelectionHandler = config.areDaysSelectable ? daySelectionHandler : nil
    }

    func setContent(datesToStatus: [Date: [CalendarDayStatus]], highlightedDates: [Date] = []) {
        let normalizedDatesToTypes = Dictionary(uniqueKeysWithValues:
            datesToStatus.map { (key: Date, value: [CalendarDayStatus]) in
                (calendar.trimTimeFromDate(key) ?? key, value)
            }
        )

        self.datesToStatus = normalizedDatesToTypes
        self.highlightedDates = highlightedDates

        calendarView.setContent(makeContent())
    }

    private func makeContent() -> CalendarViewContent {
        if let today = calendar.trimTimeFromDate(Date()) {
            todayComponents = calendar.dateComponents([.weekday, .month, .year], from: today)
        }

        let constants = theme.constants
        let daySpacing = constants.calendarViewDaySpacing

        return CalendarViewContent(calendar: calendar,
                                   visibleDateRange: config.dateRange,
                                   monthsLayout: MonthsLayout.horizontal(monthWidth: width))
            .withInterMonthSpacing(constants.calendarViewInterMonthSpacing)
            .withVerticalDayMargin(daySpacing)
            .withHorizontalDayMargin(daySpacing)
            .withDayItemProvider(dayItemProvider)
            .withDayRangeItemProvider(for: selection.allRanges(calendar: calendar), dayRangeItemProvider)
            .withDayOfWeekItemProvider(dayOfWeekItemProvider)
            .withMonthHeaderItemProvider(monthHeaderItemProvider)
    }

    private func updateContent() {
        isDirty = true
        calendarView.setContent(makeContent())
        delegate?.managedCalendarViewSelectionDidChange(self, selection: selection, selectedDates: selectedDates)
    }

    // MARK: Content Providers

    private func dayOfWeekItemProvider(month: Month?, dayIndex: Int) -> AnyCalendarItem {
        return CalendarItem<UILabel, CalendarMonthAndDayIndex>(
            viewModel: CalendarMonthAndDayIndex(month: month, dayIndex: dayIndex),
            styleID: "DayOfWeekLabelStyle",
            buildView: { return UILabel() },
            updateViewModel: { self.styleDayOfWeekItemLabel($0, monthAndDayIndex: $1) })
    }

    private func monthHeaderItemProvider(month: Month) -> AnyCalendarItem {
        return CalendarItem<UILabel, Month>(
            viewModel: month,
            styleID: "MonthHeaderLabelStyle",
            buildView: { return UILabel() },
            updateViewModel: { self.styleMonthHeaderLabel($0, month: $1) })
    }

    private func dayItemProvider(day: Day) -> AnyCalendarItem {
        let status: [CalendarDayStatus]
        if let date = day.date(calendar: calendar), let calendarDayStatus = datesToStatus[date] {
            status = calendarDayStatus
        } else {
            status = []
        }

        let selectionStyle: CalendarDayViewSelectionStyle
        if isDirty {
            selectionStyle = selection.styleForDay(day)
        } else {
            selectionStyle = config.initialDateSelection.styleForDay(day, calendar: calendar)
        }

        var isHighlighted = false
        if let date = day.date(calendar: calendar), highlightedDates.contains(date) {
            isHighlighted = true
        }

        return CalendarItem<CalendarDayView, CalendarDay>(
            viewModel: CalendarDay(day: day,
                                   status: status,
                                   isHighlighted: isHighlighted,
                                   selectionStyle: selectionStyle,
                                   accessoryStyle: config.accessoryStyle),
            styleID: selectionStyle.rawValue,
            buildView: { CalendarDayView() },
            updateViewModel: { $0.styleWith(theme: self.theme, calendar: self.calendar, displayable: $1) },
            updateHighlightState: { $0.isHighlighted = $1 })
    }

    private func dayRangeItemProvider(context: CalendarViewContent.DayRangeLayoutContext) -> AnyCalendarItem {
        var activeRangeFrames: [CGRect] = []
        var inactiveRangeFrames: [CGRect] = []

        // sort frames in `context.daysAndFrames` into active and inactive groups
        // `context.daysAndFrames` contains all days and frames determined by `selection.allRanges`
        if let activeRange = selection.activeRange(calendar: calendar) {
            for (day, frame) in context.daysAndFrames {
                if let date = day.date(calendar: calendar), activeRange.contains(date) {
                    activeRangeFrames.append(frame)
                } else {
                    inactiveRangeFrames.append(frame)
                }
            }
        } else {
            // no active range, all frames are inactive
            inactiveRangeFrames = context.daysAndFrames.map { $0.frame }
        }

        let colors = theme.colors
        let activeRangeColor = colors.backgroundCalendarRangeBoundary
        let inactiveRangeColor = colors.backgroundCalendarRangeBoundaryInactive

        return CalendarItem<CalendarRangesView, CalendarRanges>(
            viewModel: CalendarRanges(ranges: [
                CalendarRange(frames: activeRangeFrames, color: activeRangeColor),
                CalendarRange(frames: inactiveRangeFrames, color: inactiveRangeColor)
            ]),
            styleID: "CalendarRangeViewStyle",
            buildView: { CalendarRangesView() },
            updateViewModel: { $0.ranges = $1 })
    }

    // MARK: Style

    private func styleDayOfWeekItemLabel(_ label: UILabel, monthAndDayIndex: CalendarMonthAndDayIndex) {
        let colors = theme.colors

        let textColor: UIColor
        if todayComponents.weekday == monthAndDayIndex.dayIndex + 1 &&
            todayComponents.month == monthAndDayIndex.month?.month {
            textColor = colors.textHighEmphasis
        } else {
            textColor = colors.textMediumEmphasis
        }

        let weekdayString = self.calendar.shortWeekdaySymbols[monthAndDayIndex.dayIndex].uppercased()
        label.attributedText = weekdayString.attributed(fontStyle: .bodyLarge,
                                                        color: textColor,
                                                        alignment: .center)
    }

    private func styleMonthHeaderLabel(_ label: UILabel, month: Month) {
        let monthString = self.calendar.monthSymbols[month.month - 1]
        let monthHeaderString: String = (month.year == todayComponents.year)
            ? monthString : "\(monthString) \(month.year)"

        label.attributedText = monthHeaderString.attributed(fontStyle: .labelLarge,
                                                            color: self.theme.colors.textHighEmphasis,
                                                            alignment: .center,
                                                            additionalAttributes: FontStyle.attributesUnderline())
    }

    // MARK: Selection

    func deleteActiveRange() {
        if case .multiRange(let partial, let ranges) = selection,
            case .fullRange(let activeRange) = partial,
            let activeRangeIndex = ranges.firstIndex(of: activeRange) {
            var mutableRanges = ranges
            mutableRanges.remove(at: activeRangeIndex)
            selection = .multiRange(.none, mutableRanges)
            updateContent()
        }
    }

    private func daySelectionHandler(day: Day) {
        selection = selection.computeNextSelection(newlySelectedDay: day, calendar: calendar)
        updateContent()
    }

    // MARK: Scroll

    public func scrollTo(date: Date) {
        if config.dateRange.contains(date) {
            calendarView.scroll(toMonthContaining: date, scrollPosition: .centered, animated: true)
        } else {
            delegate?.managedCalendarViewTriedOverscroll(self)
        }
    }

    // MARK: Helpers

    private func computeSelectedDates(calendar: Calendar) -> [Date] {
        var selectedDates = Set<Date>()
        switch selection {
        case .singleDay(let day):
            if let day = day, let date = day.date(calendar: calendar) {
                selectedDates.insert(date)
            }
        case .multiDay(let days):
            _ = days.map {
                if let date = $0.date(calendar: calendar) {
                    selectedDates.insert(date)
                }
            }
        case  .singleRange(_, let range):
            if let range = range, let dateRange = range.toDateRange(calendar: calendar) {
                _ = calendar.dates(from: dateRange.lowerBound, to: dateRange.upperBound)
                    .map { selectedDates.insert($0) }
            }
        case .multiRange(_, let ranges):
            for range in ranges {
                if let dateRange = range.toDateRange(calendar: calendar) {
                    _ = calendar.dates(from: dateRange.lowerBound, to: dateRange.upperBound)
                        .map { selectedDates.insert($0) }
                }
            }
        case .viewOnly:
            break
        }

        return Array(selectedDates)
    }
}
