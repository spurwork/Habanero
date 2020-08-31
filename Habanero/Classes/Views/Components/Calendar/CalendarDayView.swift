import HorizonCalendar

// MARK: - CalendarDayStatus

/// Describes a day's status.
public enum CalendarDayStatus {
    /// Needs attention.
    case needsAttention
    /// Normal.
    case normal
    /// No status.
    case none

    func backgroundColor(colors: Colors) -> UIColor {
        switch self {
        case .normal: return colors.backgroundCalendarDayNormal
        case .needsAttention: return colors.backgroundCalendarDayNeedsAttention
        case .none: return .clear
        }
    }
}

// MARK: - CalendarDayViewAccessoryStyle

/// Describes the accessory view(s) used for a `CalendarDayView`.
public enum CalendarDayViewAccessoryStyle {
    /// No accessory view.
    case none
    /// A single dot representing status.
    case status
    /// A label representing the number of status as a Roman numeral.
    case multiStatus
}

// MARK: - CalendarDayViewSelectionStyle: String

enum CalendarDayViewSelectionStyle: String {
    case singleSelect
    case activeRangeBoundary
    case inactiveRangeBoundary
    case startRangeBoundary
    case none

    var darkBackground: Bool {
        switch self {
        case .none, .startRangeBoundary: return false
        case .activeRangeBoundary, .inactiveRangeBoundary, .singleSelect: return true
        }
    }

    var isBoundaryStyle: Bool {
        return self != .none
    }

    // MARK: Helpers

    func backgroundColor(colors: Colors) -> UIColor {
        switch self {
        case .activeRangeBoundary, .singleSelect: return colors.backgroundCalendarRangeBoundary
        case .startRangeBoundary: return colors.backgroundCalendarRangeBoundaryStart
        case .inactiveRangeBoundary: return colors.backgroundCalendarRangeBoundaryInactive
        case .none: return .clear
        }
    }
}

// MARK: - CalendarDayViewDisplayable

protocol CalendarDayViewDisplayable {
    var day: Day { get }
    var status: [CalendarDayStatus] { get }
    var isHighlighted: Bool { get }
    var selectionStyle: CalendarDayViewSelectionStyle { get }
    var accessoryStyle: CalendarDayViewAccessoryStyle { get }
}

// MARK: - CalendarDayView: BaseView

class CalendarDayView: BaseView {

    // MARK: Properties

    private let backgroundView = UIView(frame: .zero)
    private let stackView = UIStackView(frame: .zero)

    private let dayLabel = UILabel(frame: .zero)

    private let accessoryDotView = UIView(frame: .zero)
    private let accessoryLabel = UILabel(frame: .zero)

    private var displayable: CalendarDayViewDisplayable?

    private let highlightColor = UIColor.black.withAlphaComponent(0.1)

    var dayAccessibilityText: String?

    var isHighlighted = false {
        didSet {
            if let displayable = displayable, displayable.selectionStyle == .none, !displayable.isHighlighted {
                backgroundView.backgroundColor = isHighlighted ? highlightColor : .clear
            } else if let displayable = displayable {
                backgroundView.backgroundColor = displayable.isHighlighted ? highlightColor : .clear
            } else {
                backgroundView.backgroundColor = .clear
            }
        }
    }

    override var visualConstraintViews: [String: AnyObject] {
        return [
            "stackView": stackView,
            "dayLabel": dayLabel,
            "accessoryDotView": accessoryDotView,
            "backgroundView": backgroundView
        ]
    }

    override var visualConstraints: [String] {
        return [
            "H:|[stackView]|",
            "V:|[stackView]|",
            "H:|[backgroundView]|",
            "V:|[backgroundView]|"
        ]
    }

    // MARK: Life Cycle

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    // MARK: BaseView

    override func addSubviews() {
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(accessoryDotView)
        stackView.addArrangedSubview(accessoryLabel)

        addSubview(backgroundView)
        addSubview(stackView)
    }

    // MARK: Helpers

    func styleWith(theme: Theme, calendar: Calendar, displayable: CalendarDayViewDisplayable) {
        self.displayable = displayable

        let colors = theme.colors
        let constants = theme.constants

        let day = displayable.day
        let status = displayable.status
        let selectionStyle = displayable.selectionStyle
        let accessoryStyle = displayable.accessoryStyle

        var dateWithoutTime = Date()
        if let date = day.date(calendar: calendar),
            let dayDateWithoutTime = calendar.trimTimeFromDate(date) {
            dateWithoutTime = dayDateWithoutTime
        }
        let isToday = calendar.isDateInToday(dateWithoutTime)

        // background
        if !selectionStyle.isBoundaryStyle {
            backgroundView.layer.borderColor = UIColor.black.cgColor
            backgroundView.layer.borderWidth = isToday ? 1 : 0
            backgroundView.backgroundColor = displayable.isHighlighted ? highlightColor : .clear
        } else {
            backgroundView.backgroundColor = selectionStyle.backgroundColor(colors: colors)
        }

        // stack view
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.isLayoutMarginsRelativeArrangement = true

        // accessory view
        switch accessoryStyle {
        case .none:
            accessoryDotView.isHidden = true
            accessoryLabel.isHidden = true
            stackView.layoutMargins = constants.calendarDayViewInsets
        case .status:
            accessoryDotView.isHidden = false
            accessoryLabel.isHidden = true
            stackView.layoutMargins = constants.calendarDayViewInsetsWithStatus

            let dotDimension: CGFloat = constants.calendarViewDotDimension
            if accessoryDotView.layer.cornerRadius == 0 {
                NSLayoutConstraint.activate([
                    accessoryDotView.widthAnchor.constraint(equalToConstant: dotDimension),
                    accessoryDotView.heightAnchor.constraint(equalToConstant: dotDimension)
                ])
                accessoryDotView.layer.cornerRadius = dotDimension / 2
            }

            let displayStatus: CalendarDayStatus
            if status.contains(.needsAttention) {
                displayStatus = .needsAttention
            } else {
                displayStatus = status.contains(.normal) ? .normal : .none
            }

            if displayStatus != .none {
                accessoryDotView.backgroundColor = selectionStyle.darkBackground ?
                .white : displayStatus.backgroundColor(colors: colors)
            } else {
                accessoryDotView.backgroundColor = .clear
            }
        case .multiStatus:
            accessoryDotView.isHidden = true
            accessoryLabel.isHidden = false
            stackView.layoutMargins = constants.calendarDayViewInsetsWithMultiStatus

            let statusString: String
            if status.count > 9 {
                statusString = "9+"
            } else {
                statusString = status.isEmpty ? "" : "\(status.count)"
            }

            accessoryLabel.attributedText = statusString.attributed(fontStyle: .bodySmall,
                                                                    color: colors.textDisabled,
                                                                    alignment: .center)
        }

        // day label
        let lightTextColor = isToday ? colors.textHighEmphasis : colors.textMediumEmphasis
        let textColor = selectionStyle.darkBackground ? .white : lightTextColor
        dayLabel.attributedText = "\(day.day)".attributed(fontStyle: .bodyLarge,
                                                          color: textColor,
                                                          alignment: .center)
    }
}

// MARK: - CalendarDayView (UIAccessibility)

extension CalendarDayView {
    // swiftlint:disable unused_setter_value
    override var isAccessibilityElement: Bool {
        get { true }
        set { }
    }

    override var accessibilityLabel: String? {
        get { dayAccessibilityText ?? dayLabel.text }
        set { }
    }
    // swiftlint:enable unused_setter_value
}
