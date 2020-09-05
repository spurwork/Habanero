// MARK: - FooterDisplayable

public protocol FooterDisplayable {
    /// Describes the buttons that should be displayed in the `Footer`.
    var buttonState: FooterButtonState { get }

    /// The content to embed in the `Footer`.
    var content: FooterContent { get }
}

// MARK: - FooterDelegate

public protocol FooterDelegate: class {
    func footerButtonWasTapped(_ footer: Footer, position: FooterButtonPosition)
}

// MARK: - Footer: BaseView

public class Footer: BaseView {

    // MARK: Properites

    private let mainStackView = UIStackView(frame: .zero)
    private let aboveContentStackView = UIStackView(frame: .zero)
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

    public weak var delegate: FooterDelegate?

    private var lastDisplayable: FooterDisplayable?

    // MARK: BaseView

    public override func addSubviews() {
        buttonStackView.addArrangedSubview(leftButton)
        buttonStackView.addArrangedSubview(centerButton)
        buttonStackView.addArrangedSubview(rightButton)

        mainStackView.addArrangedSubview(aboveContentStackView)
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

    // MARK: Actions

    @objc func buttonTapped(_ button: UIButton) {
        let position: FooterButtonPosition
        if button.tag == 0 {
            position = .left
        } else {
            position = (button.tag == 1) ? .center : .right
        }

        delegate?.footerButtonWasTapped(self, position: position)
    }

    // MARK: Custom Styling

    public func styleWith(theme: Theme, displayable: FooterDisplayable) {
        lastDisplayable = displayable

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
    }

    private func styleStackViews(theme: Theme) {
        // TODO: remove magic!
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = UIEdgeInsets(uniform: 16)
        mainStackView.axis = .vertical
        mainStackView.spacing = 18

        aboveContentStackView.isLayoutMarginsRelativeArrangement = true
        aboveContentStackView.layoutMargins = UIEdgeInsets(uniform: 16)
        aboveContentStackView.axis = .vertical

        buttonStackView.spacing = 16
        buttonStackView.distribution = .fillEqually
        buttonStackView.axis = .horizontal
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
}
