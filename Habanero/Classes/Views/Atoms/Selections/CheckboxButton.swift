// MARK: - CheckboxButton: UIButton, SelectionControlButton

final class CheckboxButton: UIButton, SelectionControlButton {

    // MARK: Properties

    private var theme: Theme?
    weak var delegate: SelectionControlButtonDelegate?

    var sideLength: CGFloat {
        return theme?.constants.checkboxSideLength ?? 28
    }

    var cornerRadius: CGFloat {
        return theme?.constants.checkboxCornerRadius ?? 4
    }

    var deSelectedSquare = CAShapeLayer()
    var selectedSquare = CAShapeLayer()
    var pressedCircleLayer = CAShapeLayer()

    var deSelectedSquareColor = UIColor.black {
        didSet { deSelectedSquare.strokeColor = deSelectedSquareColor.cgColor }
    }

    var deSelectedSquareWidth: CGFloat = 2.0 {
        didSet { setSquareLayers() }
    }

    var selectedSquareColor = UIColor.black {
        didSet { setFillState() }
    }

    var circleRadius: CGFloat {
        return bounds.width / 2
    }

    var circleFrame: CGRect {
        let side = bounds.width
        return CGRect(x: 0, y: 0, width: side, height: side)
    }

    private var fullSquarePath: UIBezierPath {
        return UIBezierPath(roundedRect: CGRect(x: bounds.minX, y: bounds.minY, width: sideLength, height: sideLength),
                            cornerRadius: cornerRadius)
    }

    private var smallerSquarePath: UIBezierPath {
        return UIBezierPath(roundedRect: CGRect(x: bounds.minX, y: bounds.minY, width: sideLength, height: sideLength),
                            cornerRadius: cornerRadius)
    }

    private var pressedCirclePath: UIBezierPath {
        let inset = theme?.constants.checkboxPressedCircleInset ?? 4
        return UIBezierPath(roundedRect: circleFrame.insetBy(dx: -inset, dy: -inset),
                            cornerRadius: bounds.width)
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
        setSquareLayers()
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
        layer.insertSublayer(pressedCircleLayer, below: imageView?.layer)

        selectedSquare.frame = bounds
        selectedSquare.fillColor = UIColor.clear.cgColor
        selectedSquare.strokeColor = UIColor.clear.cgColor
        layer.insertSublayer(selectedSquare, below: imageView?.layer)

        deSelectedSquare.frame = bounds
        deSelectedSquare.lineWidth = deSelectedSquareWidth
        deSelectedSquare.fillColor = UIColor.clear.cgColor
        deSelectedSquare.strokeColor = deSelectedSquareColor.cgColor
        layer.insertSublayer(deSelectedSquare, below: imageView?.layer)

        setFillState()
    }

    func styleWith(theme: Theme) {
        self.theme = theme

        frame.size = CGSize(width: sideLength, height: sideLength)

        let colors = theme.colors
        deSelectedSquareColor = colors.backgroundSelectionButtonCheckbox
        tintColor = colors.tintSelectionButtonCheckbox

        isAccessibilityElement = true
        accessibilityIdentifier = "checkbox"

        styleSelected(theme: theme, selected: isSelected)
    }

    func styleSelected(theme: Theme, selected: Bool) {
        let colors = theme.colors
        let images = theme.images

        if selected {
            setImage(images.checkSmall, for: .normal)
            selectedSquareColor = colors.backgroundSelectionButtonCheckbox
        } else {
            setImage(nil, for: .normal)
            selectedSquareColor = .clear
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

    private func setSquareLayers() {
        deSelectedSquare.frame = bounds
        deSelectedSquare.cornerRadius = cornerRadius
        deSelectedSquare.path = smallerSquarePath.cgPath

        selectedSquare.frame = bounds
        selectedSquare.cornerRadius = cornerRadius
        selectedSquare.path = fullSquarePath.cgPath

        pressedCircleLayer.frame = bounds
        pressedCircleLayer.path = pressedCirclePath.cgPath
    }

    private func setFillState() {
        if self.isSelected {
            selectedSquare.fillColor = selectedSquareColor.cgColor
        } else {
            selectedSquare.fillColor = UIColor.clear.cgColor
        }
    }
}
