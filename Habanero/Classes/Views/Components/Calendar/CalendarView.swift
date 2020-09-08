import HorizonCalendar

// MARK: - CalendarViewConfig

/// Settings to apply to a `CalendarView`.
public struct CalendarViewConfig {
    let dateRange: ClosedRange<Date>
    let accessoryStyle: CalendarDayViewAccessoryStyle
    let initialDateSelection: CalendarDateSelection
    let areDaysSelectable: Bool

    /// Creates a `CalendarViewConfig`.
    /// - Parameters:
    ///   - dateRange: The range of dates to display with a `CalendarView`.
    ///   - accessoryStyle: The style to apply to `CalendarDayView` within a `CalendarView`.
    ///   - initialDateSelection: Dates to show as selected on initialization.
    ///   - areDaysSelectable: Can the `CalendarView` selection be adjusted?
    public init(dateRange: ClosedRange<Date>,
                accessoryStyle: CalendarDayViewAccessoryStyle,
                initialDateSelection: CalendarDateSelection,
                areDaysSelectable: Bool) {
        self.dateRange = dateRange
        self.accessoryStyle = accessoryStyle
        self.initialDateSelection = initialDateSelection
        self.areDaysSelectable = areDaysSelectable
    }
}

// MARK: - CalendarViewDelegate

public protocol CalendarViewDelegate: class {
    func calendarViewTriedOverscroll(_ calendarView: CalendarView)
    func calendarViewSelectionDidChange(_ calendarView: CalendarView,
                                        selection: CalendarDaySelection,
                                        selectedDates: [Date])
}

// MARK: - CalendarView: BaseView

public class CalendarView: BaseView {

    // MARK: Properties

    private let leftButton = UIButton(type: .system)
    private let rightButton = UIButton(type: .system)
    // NOTE: Consider simple popover for contextual actions÷
    private let clearButton = UIButton(type: .system)

    private let managedCalendarView: ManagedCalendarView
    private let theme: Theme

    public weak var delegate: CalendarViewDelegate?

    // MARK: Initializer

    public init(theme: Theme,
                width: CGFloat,
                config: CalendarViewConfig) {
        self.theme = theme

        let sideButtonWidth = theme.constants.calendarViewMinimumButtonDimension
        managedCalendarView = ManagedCalendarView(theme: theme,
                                                  width: width - (sideButtonWidth * 2),
                                                  config: config)
        managedCalendarView.initContent()

        super.init(frame: .zero)

        managedCalendarView.delegate = self
    }

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(leftButton)
        addSubview(managedCalendarView.calendarView)
        addSubview(rightButton)
        addSubview(clearButton)
    }

    public override func addTargets() {
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }

    // MARK: Style

    public func styleWith(theme: Theme, datesToStatus: [Date: [CalendarDayStatus]], highlightedDates: [Date] = []) {
        let images = theme.images

        styleCalendarButton(theme: theme, button: leftButton, image: images.caretLeftThick)
        styleCalendarButton(theme: theme, button: rightButton, image: images.caretRightThick)

        clearButton.isHidden = true
        clearButton.setImage(images.closeCircle, for: .normal)
        clearButton.imageView?.contentMode = .scaleAspectFit

        if managedCalendarView.calendarView.translatesAutoresizingMaskIntoConstraints {
            addExtraConstraints(theme: theme)
        }

        managedCalendarView.setContent(datesToStatus: datesToStatus, highlightedDates: highlightedDates)
    }

    private func styleCalendarButton(theme: Theme, button: UIButton, image: UIImage?) {
        let colors = theme.colors
        let constants = theme.constants

        button.imageEdgeInsets = constants.calendarViewButtonImageInsets
        button.contentVerticalAlignment = .top
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = colors.tintCalendarButton
    }

    private func addExtraConstraints(theme: Theme) {
        let visualConstraintViews: [String: AnyObject] = [
            "leftButton": leftButton,
            "rightButton": rightButton,
            "calendarView": managedCalendarView.calendarView,
            "clearButton": clearButton
        ]

        let buttonDimension = theme.constants.calendarViewMinimumButtonDimension
        let visualConstraints = [
            "V:|[leftButton]|",
            "V:|[rightButton]|",
            "V:|[calendarView]|",
            "H:|[leftButton(\(buttonDimension))][calendarView][rightButton(\(buttonDimension))]|",
            "H:[clearButton(\(buttonDimension))]|",
            "V:[clearButton(\(buttonDimension))]|"
        ]

        addVisualConstraints(visualConstraintViews: visualConstraintViews, visualConstraints: visualConstraints)
    }

    // MARK: Helpers

    public func scrollTo(date: Date) {
        managedCalendarView.scrollTo(date: date)
    }

    // MARK: Action

    @objc func leftButtonTapped() {
        if let minVisibleDate = managedCalendarView.minVisibleDate,
            let oneMonthBefore = Calendar.current.date(byAdding: .day, value: -1, to: minVisibleDate) {
            scrollTo(date: oneMonthBefore)
        }
    }

    @objc func rightButtonTapped() {
        if let maxVisibleDate = managedCalendarView.maxVisibleDate,
            let oneMonthAfter = Calendar.current.date(byAdding: .day, value: 1, to: maxVisibleDate) {
            scrollTo(date: oneMonthAfter)
        }
    }

    @objc func clearButtonTapped() {
        managedCalendarView.deleteActiveRange()
    }
}

// MARK: - CalendarView: ManagedCalendarViewDelegate

extension CalendarView: ManagedCalendarViewDelegate {
    func managedCalendarViewTriedOverscroll(_ managedCalendarView: ManagedCalendarView) {
        delegate?.calendarViewTriedOverscroll(self)
    }

    func managedCalendarViewSelectionDidChange(_ managedCalendarView: ManagedCalendarView,
                                               selection: CalendarDaySelection,
                                               selectedDates: [Date]) {
        clearButton.isHidden = !selection.allowActiveRangeDeletion
        delegate?.calendarViewSelectionDidChange(self, selection: selection, selectedDates: selectedDates)
    }
}
