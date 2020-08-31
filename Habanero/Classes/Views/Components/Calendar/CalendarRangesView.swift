// MARK: - CalendarRangesView

class CalendarRangesView: UIView {

    // MARK: Properties

    var ranges: CalendarRanges {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: Initializer

    init() {
        ranges = CalendarRanges(ranges: [])

        super.init(frame: .zero)
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Draw

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        for range in ranges.ranges {
            context?.setFillColor(range.color.withAlphaComponent(0.15).cgColor)

            // get frames of day rows in the range
            var dayRowFrames = [CGRect]()
            var currentDayRowMinY: CGFloat?
            for dayFrame in range.frames {
                if dayFrame.minY != currentDayRowMinY {
                    currentDayRowMinY = dayFrame.minY
                    dayRowFrames.append(dayFrame)
                } else {
                    let lastIndex = dayRowFrames.count - 1
                    dayRowFrames[lastIndex] = dayRowFrames[lastIndex].union(dayFrame)
                }
            }

            // draw rounded rectangles for each day row
            for dayRowFrame in dayRowFrames {
                let cornerRadius = dayRowFrame.height / 2
                let roundedRectanglePath = UIBezierPath(roundedRect: dayRowFrame, cornerRadius: cornerRadius)
                context?.addPath(roundedRectanglePath.cgPath)
                context?.fillPath()
            }
        }
    }
}
