// MARK: - SelectionControlType

/// A control that can be selected.
public enum SelectionControlType {
    /// A checkbox.
    case checkbox
    /// A radio button.
    case radio
}

// MARK: - SelectionControlDisplayable

/// An object that can be displayed by a `SelectionControl`.
public protocol SelectionControlDisplayable {
    /// The title displayed for the selection control.
    var title: String { get }

    /// The tip displayed for the selection control.
    var tip: String? { get }

    /// Does the tip link to something?
    var tipLinkable: Bool { get }

    /// Is the control selected?
    var isSelected: Bool { get }

    /// Is the control enabled?
    var isEnabled: Bool { get }
}

// MARK: - SelectionControlDelegate

/// An object that can respond to `SelectionControl` events.
public protocol SelectionControlDelegate: class {
    func selectionControlWasTapped(_ selectionControl: SelectionControl)
}

// MARK: - SelectionControlTipDelegate

/// An object that can respond to events emitted by the tip label in a `SelectionControl`.
public protocol SelectionControlTipDelegate: class {
    func selectionControlTipWasTapped(_ selectionControl: SelectionControl)
}

// MARK: - SelectionControl: BaseControl

public class SelectionControl: BaseControl {

    // MARK: Properties

    private let mainStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        return stackView
    }()

    private let textStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        return stackView
    }()

    private let titleLabel = SelectionLabel(frame: .zero)
    private let selectionControlButton: SelectionControlButton
    private let tipLabel = SelectionLabel(frame: .zero)

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "mainStackView": mainStackView,
            "textStackView": textStackView
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[mainStackView]|",
            "V:|[mainStackView]|",
            "V:|[textStackView]|"
        ]
    }

    private var selectionControlButtonHeight: NSLayoutConstraint?
    private var selectionControlButtonWidth: NSLayoutConstraint?

    public override var isEnabled: Bool {
        didSet {
            titleLabel.isEnabled = isEnabled
            selectionControlButton.isEnabled = isEnabled
            tipLabel.isEnabled = isEnabled
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            titleLabel.isHighlighted = isHighlighted
            selectionControlButton.isHighlighted = isHighlighted
            tipLabel.isHighlighted = isHighlighted
        }
    }

    public override var isSelected: Bool {
        didSet {
            titleLabel.isSelected = isSelected
            selectionControlButton.isSelected = isSelected
            tipLabel.isSelected = isSelected
        }
    }

    private let type: SelectionControlType

    public var theme: Theme?
    public var displayable: SelectionControlDisplayable?

    public weak var delegate: SelectionControlDelegate?
    public weak var tipDelegate: SelectionControlTipDelegate?

    // MARK: Initializer

    public init(frame: CGRect, type: SelectionControlType) {
        self.type = type

        selectionControlButton = (type == .radio)
            ? RadioButton(origin: .zero, selected: false)
            : CheckboxButton(origin: .zero, selected: false)

        super.init(frame: frame)
    }

    // MARK: BaseControl

    public override func addSubviews() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(tipLabel)

        mainStackView.addArrangedSubview(selectionControlButton)
        mainStackView.addArrangedSubview(textStackView)

        addSubview(mainStackView)
    }

    public override func addTargets() {
        selectionControlButton.delegate = self

        titleLabel.tag = 0
        titleLabel.delegate = self

        tipLabel.tag = 1
        tipLabel.delegate = self
    }

    // MARK: UIView

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let theme = theme, let displayable = displayable else { return }
        styleWith(theme: theme, displayable: displayable)
    }

    // MARK: Actions

    @objc private func selectionControlTouchUp(control: UIControl) {
        delegate?.selectionControlWasTapped(self)
    }

    // MARK: Style

    public func styleWith(theme: Theme, displayable: SelectionControlDisplayable) {
        self.theme = theme
        self.displayable = displayable

        titleLabel.theme = theme
        tipLabel.theme = theme

        let constants = theme.constants
        let colors = theme.colors

        if case .radio = type {
            mainStackView.spacing = constants.selectionControlButtonToTitleSpacing
        } else {
            mainStackView.spacing = constants.selectionControlButtonToTitleSpacing
            mainStackView.isLayoutMarginsRelativeArrangement = true
            mainStackView.layoutMargins = constants.checkboxLayoutMargins
        }

        textStackView.spacing = constants.selectionControlTextSpacing

        titleLabel.label.numberOfLines = 0
        titleLabel.label.attributedText = displayable.title.attributed(fontStyle: .labelLarge,
                                                                       color: colors.textHighEmphasis)

        tipLabel.label.numberOfLines = 0
        if let tip = displayable.tip {
            mainStackView.alignment = .top
            tipLabel.isHidden = false

            let additionalAttributes = (displayable.tipLinkable) ? FontStyle.attributesUnderline() : [:]
            tipLabel.label.attributedText = tip.attributed(fontStyle: .labelLarge,
                                                           color: colors.textMediumEmphasis,
                                                           additionalAttributes: additionalAttributes)
        } else {
            mainStackView.alignment = .center
            tipLabel.isHidden = true
        }

        let dimension = (type == .radio)
            ? constants.radioButtonDiameter
            : constants.checkboxSideLength

        if selectionControlButtonWidth == nil && selectionControlButtonHeight == nil {
            selectionControlButtonHeight = NSLayoutConstraint(item: selectionControlButton,
                                                              attribute: .height,
                                                              relatedBy: .equal,
                                                              toItem: nil,
                                                              attribute: .notAnAttribute,
                                                              multiplier: 1,
                                                              constant: dimension)
            selectionControlButtonWidth = NSLayoutConstraint(item: selectionControlButton,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1,
                                                             constant: dimension)
            if let selectionControlButtonWidth = selectionControlButtonWidth,
                let selectionControlButtonHeight = selectionControlButtonHeight {
                NSLayoutConstraint.activate([selectionControlButtonHeight, selectionControlButtonWidth])
            }
        }

        selectionControlButton.styleWith(theme: theme)

        isSelected = displayable.isSelected
        isEnabled = displayable.isEnabled
    }

    // MARK: Helpers

    public func setControlTag(_ tag: Int) {
        selectionControlButton.tag = tag
    }

    public func getControlTag() -> Int {
        return selectionControlButton.tag
    }

    public func toggle() {
        selectionControlButton.isSelected = !selectionControlButton.isSelected
    }

    public func markSelected(_ selected: Bool) {
        selectionControlButton.isSelected = selected
    }
}

// MARK: - SelectionControl: SelectionControlButtonDelegate

extension SelectionControl: SelectionControlButtonDelegate {
    func selectionControlButtonWasTapped(_ button: UIButton) {
        selectionControlTouchUp(control: button)
    }
}

// MARK: - SelectionControl: SelectionLabelDelegate

extension SelectionControl: SelectionLabelDelegate {
    func selectionLabelWasTouchedUp(_ selectionLabel: SelectionLabel) {
        if selectionLabelIsLinkable(selectionLabel) {
            tipDelegate?.selectionControlTipWasTapped(self)
        } else {
            guard let theme = theme else { return }
            selectionControlButton.stylePressed(theme: theme, pressed: false)
            selectionControlTouchUp(control: selectionLabel)
        }
    }

    func selectionLabelWasTouchedDown(_ selectionLabel: SelectionLabel) {
        if !selectionLabelIsLinkable(selectionLabel) {
            guard let theme = theme else { return }
            selectionControlButton.stylePressed(theme: theme, pressed: true)
        }
    }

    private func selectionLabelIsLinkable(_ selectionLabel: SelectionLabel) -> Bool {
        if let displayable = displayable,
            tipDelegate != nil,
            selectionLabel.tag == 1,
            displayable.tipLinkable {
            return true
        } else {
            return false
        }
    }
}
