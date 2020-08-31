// MARK: - TextInputCountViewDelegate

protocol TextInputCountViewDelegate: class {
    func textInputCountViewButtonTapped(_ textInputCountView: TextInputCountView)
}

// MARK: - TextInputCountView: BaseView

class TextInputCountView: BaseView {

    // MARK: Properties

    private let stackView = UIStackView(frame: .zero)
    private let label = UILabel(frame: .zero)

    private let button = UIButton(type: .system)
    private var buttonHeight: NSLayoutConstraint?
    private var buttonWidth: NSLayoutConstraint?

    private var wasEditing: Bool = false

    weak var delegate: TextInputCountViewDelegate?

    private var theme: Theme?
    private var displayable: TextInputDisplayable?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "stackView": stackView,
            "label": label
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[stackView]|",
            "V:|[stackView]|"
        ]
    }

    private var labelWidth: NSLayoutConstraint?

    // MARK: BaseView

    public override func addSubviews() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        addSubview(stackView)
    }

    public override func addTargets() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    // MARK: Actions

    @objc func buttonTapped() {
        delegate?.textInputCountViewButtonTapped(self)
    }

    // MARK: Style

    func styleWith(theme: Theme, displayable: TextInputDisplayable) {
        self.theme = theme
        self.displayable = displayable

        styleLabel(theme: theme, displayable: displayable)
        styleButton(theme: theme, displayable: displayable)
    }

    func styleLabel(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors
        let constants = theme.constants

        if labelWidth == nil {
            labelWidth = NSLayoutConstraint(item: label,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: constants.textInputCharacterCountLabelWidth)
            if let labelWidth = labelWidth {
                NSLayoutConstraint.activate([labelWidth])
            }
        }

        label.numberOfLines = 0
        label.isHidden = true

        let maxCharacterCount = displayable.customCharacterCount(constants: constants)
        let maxCharacterCountDigits = String("\(maxCharacterCount)").count
        let count = String(format: "%0\(maxCharacterCountDigits)d", displayable.value.count)

        label.attributedText = "\(count)/\(displayable.customCharacterCount(constants: constants))"
            .attributed(fontStyle: .labelSmall,
                        color: colors.textInputPlaceholder,
                        alignment: .right)
    }

    func styleButton(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors
        let constants = theme.constants

        if buttonHeight == nil && buttonWidth == nil {
            let sideLength = constants.textInputIconFrameSideLength
            buttonHeight = button.widthAnchor.constraint(equalToConstant: sideLength)
            buttonWidth = button.heightAnchor.constraint(equalToConstant: sideLength)
            if let buttonHeight = buttonHeight, let buttonWidth = buttonWidth {
                NSLayoutConstraint.activate([buttonHeight, buttonWidth])
            }
        }

        button.imageEdgeInsets = constants.textInputIconInsets
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = colors.tintTextInputIcon

        styleEditing(nil)
    }

    func styleEditing(_ isEditing: Bool? = nil) {
        guard let theme = theme, let displayable = displayable else { return }

        let images = theme.images
        let normalIcon = (displayable.error == nil) ? displayable.icon : images.warning

        let editing = isEditing ?? self.wasEditing

        if let isEditing = isEditing {
            self.wasEditing = isEditing
        }

        if editing {
            label.isHidden = displayable.value.isEmpty || !displayable.showCharacterCount
            button.setImage(displayable.value.isEmpty ? normalIcon : images.closeCircleFill, for: .normal)
            button.isUserInteractionEnabled = !displayable.value.isEmpty
        } else {
            label.isHidden = true
            button.setImage(normalIcon, for: .normal)
            button.isUserInteractionEnabled = false
        }
    }
}
