// MARK: - RadioButton: UIButton, SelectionControlButton

final class RadioButton: UIButton, SelectionControlButton {

    // MARK: Properties

    private var theme: Theme?
    weak var delegate: SelectionControlButtonDelegate?

    var outerCircleLayer = CAShapeLayer()
    var innerCircleLayer = CAShapeLayer()
    var pressedCircleLayer = CAShapeLayer()

    var outerCircleColor = UIColor.black {
        didSet { outerCircleLayer.strokeColor = outerCircleColor.cgColor }
    }

    var innerCircleCircleColor = UIColor.black {
        didSet { setFillState() }
    }

    var outerCircleLineWidth: CGFloat = 2.0 {
        didSet { setCircleLayouts() }
    }

    var innerCircleGap: CGFloat = 2.0 {
        didSet { setCircleLayouts() }
    }

    var setCircleRadius: CGFloat {
        let width = bounds.width
        let height = bounds.height

        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }

    var setCircleFrame: CGRect {
        let width = bounds.width
        let height = bounds.height

        let radius = setCircleRadius
        let xCoord: CGFloat
        let yCoord: CGFloat

        if width > height {
            yCoord = outerCircleLineWidth / 2
            xCoord = (width / 2) - radius
        } else {
            xCoord = outerCircleLineWidth / 2
            yCoord = (height / 2) - radius
        }

        let diameter = 2 * radius
        return CGRect(x: xCoord, y: yCoord, width: diameter, height: diameter)
    }

    private var circlePath: UIBezierPath {
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }

    private var fillCirclePath: UIBezierPath {
        let inset = innerCircleGap + (outerCircleLineWidth / 2)
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: inset, dy: inset),
                            cornerRadius: setCircleRadius)
    }

    private var pressedCirclePath: UIBezierPath {
        let inset = innerCircleGap + outerCircleLineWidth
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: -inset, dy: -inset),
                            cornerRadius: setCircleRadius)
    }

    // MARK: Initializer

    init(origin: CGPoint, selected: Bool) {
        super.init(frame: CGRect(origin: origin, size: CGSize(width: 0, height: 0)))
        finishInit()
        isSelected = selected
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        finishInit()
    }

    private func finishInit() {
        style()
        addTapTarget()
    }

    private func addTapTarget() {
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    // MARK: Actions

    @objc func tapped() {
        delegate?.selectionControlButtonWasTapped(self)
    }

    // MARK: UIButton

    override func prepareForInterfaceBuilder() {
        style()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setCircleLayouts()
    }

    override var isEnabled: Bool {
        didSet {
            if let theme = theme {
                styleEnabled(theme: theme, enabled: isEnabled)
            }
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if let theme = theme {
                stylePressed(theme: theme, pressed: isHighlighted)
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            setFillState()
            if let theme = theme {
                styleSelected(theme: theme, selected: isSelected)
            }
        }
    }

    // MARK: Style

    private func style() {
        pressedCircleLayer.frame = bounds
        pressedCircleLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(pressedCircleLayer)

        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(outerCircleLayer)

        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)

        setFillState()
    }

    func styleWith(theme: Theme) {
        self.theme = theme

        let constants = theme.constants
        let diameter = constants.radioButtonDiameter
        frame.size = CGSize(width: diameter, height: diameter)

        isAccessibilityElement = true
        accessibilityIdentifier = accessibilityIdentifier ?? "radio"

        styleSelected(theme: theme, selected: isSelected)
    }

    func styleSelected(theme: Theme, selected: Bool) {
        let colors = theme.colors
        let tintColor = colors.tintSelectionButtonRadio

        if selected {
            innerCircleCircleColor = tintColor
            outerCircleColor = tintColor
        } else {
            outerCircleColor = tintColor
        }
    }

    func stylePressed(theme: Theme, pressed: Bool) {
        let colors = theme.colors
        let pressedColor = colors.tintSelectionButtonPressed

        pressedCircleLayer.fillColor = pressed ? pressedColor.cgColor : UIColor.clear.cgColor
    }

    func styleEnabled(theme: Theme, enabled: Bool) {
        let constants = theme.constants
        alpha = enabled ? 1.0 : constants.alphaDisabled
    }

    // MARK: Helpers

    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = circlePath.cgPath

        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.path = fillCirclePath.cgPath

        pressedCircleLayer.frame = bounds
        pressedCircleLayer.path = pressedCirclePath.cgPath
    }

    private func setFillState() {
        innerCircleLayer.fillColor = isSelected ? innerCircleCircleColor.cgColor : UIColor.clear.cgColor
    }
}
