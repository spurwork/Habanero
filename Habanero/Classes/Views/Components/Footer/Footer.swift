// MARK: - FooterDisplayable

/// An object that can be displayed by a `Footer`.
public protocol FooterDisplayable {
    /// Describes the buttons to display.
    var buttonState: FooterButtonState { get }

    /// The content to embed in the footer.
    var content: FooterContent { get }
}

// MARK: - FooterButtonDelegate

public protocol FooterButtonDelegate: class {
    func footerButtonWasTapped(_ footer: Footer, position: FooterButtonPosition)
}

// MARK: - FooterLabelDelegate

public protocol FooterLabelDelegate: class {
    func footerLabelWasTapped(_ footer: Footer)
}

// MARK: - FooterCheckboxDelegate

public protocol FooterCheckboxDelegate: class {
    func footerCheckboxWasTapped(_ footer: Footer)
    func footerTipWasTapped(_ footer: Footer, backedValue: Any)
}

// MARK: - FooterDelegate

/// An object that responds to all messages omitted by a `Footer`.
public typealias FooterDelegate = FooterButtonDelegate & FooterLabelDelegate & FooterCheckboxDelegate

// MARK: - Footer: BaseView

public class Footer: BaseView {

    // MARK: Properites

    private let mainStackView = UIStackView(frame: .zero)
    private let contentStackView = UIStackView(frame: .zero)
    private let buttonStackView = UIStackView(frame: .zero)

    private let divider = UIView(frame: .zero)

    private let leftButton = Button(frame: .zero, style: .outline(.secondary0))
    private let centerButton = Button(frame: .zero, style: .contained(.primary))
    private let rightButton = Button(frame: .zero, style: .contained(.primary))

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "mainStackView": mainStackView,
            "divider": divider
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[mainStackView]|",
            "V:|[mainStackView]|",
            "H:|[divider]|",
            "V:|[divider(1)]"
        ]
    }

    public weak var delegate: FooterDelegate? {
        didSet {
            buttonDelegate = delegate
            labelDelegate = delegate
            checkboxDelegate = delegate
        }
    }

    public weak var buttonDelegate: FooterButtonDelegate?
    public weak var labelDelegate: FooterLabelDelegate?
    public weak var checkboxDelegate: FooterCheckboxDelegate?

    private var theme: Theme?
    private var lastDisplayable: FooterDisplayable?

    // MARK: BaseView

    public override func addSubviews() {
        buttonStackView.addArrangedSubview(leftButton)
        buttonStackView.addArrangedSubview(centerButton)
        buttonStackView.addArrangedSubview(rightButton)

        mainStackView.addArrangedSubview(contentStackView)
        mainStackView.addArrangedSubview(buttonStackView)

        addSubview(mainStackView)
        addSubview(divider)
    }

    public override func addTargets() {
        leftButton.tag = 0
        centerButton.tag = 1
        rightButton.tag = 2

        leftButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        centerButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    // MARK: Life Cycle

    public override func layoutSubviews() {
        super.layoutSubviews()

        if let superview = superview {
            layer.zPosition = 1
            translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    }

    // MARK: Actions

    @objc func buttonTapped(_ button: UIButton) {
        let position: FooterButtonPosition
        if button.tag == 0 {
            position = .left
        } else {
            position = (button.tag == 1) ? .center : .right
        }

        buttonDelegate?.footerButtonWasTapped(self, position: position)
    }

    // MARK: Custom Styling

    public func styleWith(theme: Theme, displayable: FooterDisplayable) {
        self.theme = theme
        lastDisplayable = displayable

        backgroundColor = theme.colors.backgroundFooter

        if case let .none = displayable.buttonState, case let .none = displayable.content {
            isHidden = true
            return
        } else {
            isHidden = false
        }

        if !mainStackView.isLayoutMarginsRelativeArrangement { styleStackViews(theme: theme) }
        divider.backgroundColor = theme.colors.backgroundDivider

        // buttons
        styleWith(theme: theme, buttonState: displayable.buttonState)

        // content
        styleWith(theme: theme, content: displayable.content)
    }

    private func styleWith(theme: Theme, buttonState: FooterButtonState) {
        switch buttonState {
        case .none:
            centerButton.isHidden = true
            leftButton.isHidden = true
            rightButton.isHidden = true
            buttonStackView.isHidden = true
        case .center(let title, let containedStyle):
            centerButton.styleWith(theme: theme, style: .contained(containedStyle))
            centerButton.setTitle(title, for: .normal)
            centerButton.setTitle(title, for: .disabled)
            centerButton.isHidden = false
            leftButton.isHidden = true
            rightButton.isHidden = true
        case .leftRight(let leftTitle, let rightTitle, let containedStyle):
            leftButton.styleWith(theme: theme, style: .outline(.secondary0))
            leftButton.setTitle(leftTitle, for: .normal)
            leftButton.setTitle(leftTitle, for: .disabled)
            rightButton.styleWith(theme: theme, style: .contained(containedStyle))
            rightButton.setTitle(rightTitle, for: .normal)
            rightButton.setTitle(rightTitle, for: .disabled)
            centerButton.isHidden = true
            leftButton.isHidden = false
            rightButton.isHidden = false
        }
    }

    private func styleWith(theme: Theme, content: FooterContent) {
        clearContent()

        switch content {
        case .none: return
        case .label(let displayable): addLabel(theme: theme, displayable: displayable)
        case .checkbox(let displayable, _): addCheckbox(theme: theme, displayable: displayable)
        }
    }

    private func styleStackViews(theme: Theme) {
        let constants = theme.constants

        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = constants.footerContentInsets
        mainStackView.axis = .vertical
        mainStackView.spacing = constants.footerContentSpacing

        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = constants.footerContentInsets
        contentStackView.axis = .vertical

        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = constants.footerButtonSpacing
    }

    // MARK: Content

    private func clearContent() {
        contentStackView.removeAllArrangedSubviews()
        contentStackView.isHidden = true
    }

    private func addContentSubview(_ view: UIView) {
        contentStackView.isHidden = false
        contentStackView.layoutMargins = .zero
        contentStackView.addArrangedSubview(view)
    }

    // MARK: Content (Checkbox)

    private func addCheckbox(theme: Theme, displayable: SelectionControlDisplayable) {
        let checkbox = SelectionControl(frame: .zero, type: .checkbox)
        checkbox.delegate = self
        checkbox.tipDelegate = self
        addContentSubview(checkbox)

        styleCheckbox(theme: theme, displayable: displayable)
    }

    private func styleCheckbox(theme: Theme, displayable: SelectionControlDisplayable) {
        if let checkbox = contentStackView.subviews[0] as? SelectionControl {
            checkbox.styleWith(theme: theme, displayable: displayable)
        }
    }

    // MARK: Content (Label)

    private func addLabel(theme: Theme, displayable: FooterLabelDisplayable) {
        let selectionLabel = SelectionLabel(frame: .zero)
        selectionLabel.theme = theme
        if displayable.isTappable {
            selectionLabel.delegate = self
        }
        addContentSubview(selectionLabel)

        styleLabel(theme: theme, displayable: displayable)
    }

    private func styleLabel(theme: Theme, displayable: FooterLabelDisplayable) {
        let text = displayable.text
        let normalizedText = text.isEmpty ? " " : text

        let finalText: String
        if let icon = displayable.icon {
            finalText = "\(icon)  \(normalizedText)"
        } else {
            finalText = normalizedText
        }

        if let selectionLabel = contentStackView.subviews[0] as? SelectionLabel {
            let colors = theme.colors
            let textColor = displayable.isTappable ? colors.textFooterLabelLink : colors.textHighEmphasis
            selectionLabel.label.numberOfLines = 0
            selectionLabel.label.attributedText = finalText.attributed(fontStyle: .labelLarge, color: textColor)
        }
    }
    
    // MARK: Helpers
    
    func enableButtons(_ isEnabled: Bool, positions: Set<FooterButtonPosition>) {
        for position in positions {
            switch position {
            case .left: leftButton.isEnabled = isEnabled
            case .right: rightButton.isEnabled = isEnabled
            case .center: centerButton.isEnabled = isEnabled
            }
        }
    }
    
    func hide(_ hide: Bool) {
        isUserInteractionEnabled = !hide

        UIView.animate(withDuration: 0.25) {
            self.alpha = hide ? 0.0 : 1.0
        }
    }
}

// MARK: - Footer: SelectionControlDelegate

extension Footer: SelectionControlDelegate {
    public func selectionControlWasTapped(_ selectionControl: SelectionControl) {
        guard let theme = theme else { return }

        if let lastDisplayable = lastDisplayable,
            case .checkbox(let displayable, let backedValue) = lastDisplayable.content {
            let nextCheckbox = SimpleSelectionControl(toggle: displayable)
            let nextDisplayable = FooterModel(buttonState: lastDisplayable.buttonState,
                                              content: .checkbox(nextCheckbox, backedValue))
            self.lastDisplayable = nextDisplayable
            styleCheckbox(theme: theme, displayable: nextCheckbox)
        }

        checkboxDelegate?.footerCheckboxWasTapped(self)
    }
}

// MARK: - Footer: SelectionControlTipDelegate

extension Footer: SelectionControlTipDelegate {
    public func selectionControlTipWasTapped(_ selectionControl: SelectionControl) {
        if case .checkbox(_, let backedValue) = lastDisplayable?.content {
            checkboxDelegate?.footerTipWasTapped(self, backedValue: backedValue)
        }
    }
}

// MARK: - Footer: SelectionLabelDelegate

extension Footer: SelectionLabelDelegate {
    func selectionLabelWasTouchedUp(_ selectionLabel: SelectionLabel) {
        if !contentStackView.arrangedSubviews.isEmpty {
            labelDelegate?.footerLabelWasTapped(self)
        }
    }

    func selectionLabelWasTouchedDown(_ selectionLabel: SelectionLabel) {}
}
