// MARK: - DetailTextFieldDelegate: UITextFieldDelegate

protocol DetailTextFieldDelegate: UITextFieldDelegate {
    func detailTextFieldDidDeleteBackwards(_ textField: UITextField)
    func detailTextFieldDidChange(_ textField: UITextField)
}

// MARK: - DetailTextField: BaseControl

class DetailTextField: BaseControl {

    // MARK: Properties

    private let textField = PaddedTextField(frame: .zero)
    private let countView = TextInputCountView(frame: .zero)
    private let underlineView = UIView(frame: .zero)

    private var theme: Theme?
    private var displayable: TextInputDisplayable?

    weak var delegate: DetailTextFieldDelegate?
    
    override var accessibilityLabel: String? {
        didSet {
            textField.accessibilityLabel = accessibilityLabel
            accessibilityIdentifier = accessibilityLabel
        }
    }

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "textField": textField,
            "underlineView": underlineView,
            "countView": countView
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[textField]|",
            "H:|[underlineView]|"
        ]
    }

    private var customVisualConstraints: [NSLayoutConstraint]?

    public var responder: UIResponder { return textField }

    public override var isSelected: Bool {
        didSet {
            if let theme = theme {
                let colors = theme.colors

                let currentSelectedColor = (displayable?.error == nil)
                    ? colors.colorTextInputNormal : colors.colorTextInputError
                let newSelectedColor = isSelected
                    ? colors.colorTextInputSelected : currentSelectedColor
                underlineView.backgroundColor = newSelectedColor
            }
        }
    }

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(textField)
        addSubview(underlineView)
    }

    public override func addTargets() {
        textField.delegate = self
        textField.paddedTextFieldDelegate = self

        countView.delegate = self
    }

    // MARK: Style

    public func styleWith(theme: Theme, displayable: TextInputDisplayable, formatter: TextInputFormatter?) {
        self.theme = theme
        self.displayable = displayable

        styleTextField(theme: theme, displayable: displayable, formatter: formatter)
        styleCountView(theme: theme, displayable: displayable)
        styleForError(theme: theme, displayable: displayable)
    }

    private func styleTextField(theme: Theme, displayable: TextInputDisplayable, formatter: TextInputFormatter?) {
        let colors = theme.colors
        let constants = theme.constants

        if customVisualConstraints == nil {
            let textFieldHeight = constants.detailTextFieldHeight
            let spacing = constants.textInputContentVerticalSpacing
            let underlineHeight = constants.detailTextFieldUnderlineHeight
            let visualConstraint = "V:|[textField(\(textFieldHeight))]-\(spacing)-[underlineView(\(underlineHeight))]|"
            customVisualConstraints = NSLayoutConstraint.constraints(withVisualFormat: visualConstraint,
                                                                     options: NSLayoutConstraint.FormatOptions(),
                                                                     metrics: nil,
                                                                     views: visualConstraintViews)

            if let customVisualConstraints = customVisualConstraints {
                NSLayoutConstraint.activate(customVisualConstraints)
            }
        }

        let fontStyle = constants.textInputFontStyle
        textField.font = fontStyle.font

        if let formatter = formatter, let formattedText = formatter.formatText(displayable.value) {
            textField.attributedText = formattedText.attributed(fontStyle: fontStyle, color: colors.textHighEmphasis)
        } else {
            textField.attributedText = displayable.value.attributed(fontStyle: fontStyle,
                                                                    color: colors.textHighEmphasis)
        }

        textField.isSecureTextEntry = displayable.useSecureTextEntry
        textField.keyboardType = displayable.keyboardType
        textField.textContentType = displayable.textContentType
        textField.autocorrectionType = displayable.autocorrectionType
        textField.autocapitalizationType = displayable.autocapitalizationType

        if let placeholder = displayable.placeholder {
            textField.attributedPlaceholder = placeholder.attributed(fontStyle: fontStyle,
                                                                     color: colors.textInputPlaceholder)
        } else {
            textField.attributedPlaceholder = nil
        }
    }

    private func styleForError(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors

        let nonEditingColor = (displayable.error == nil) ?
            colors.colorTextInputNormal : colors.colorTextInputError
        let underlineColor = isSelected ? colors.colorTextInputSelected : nonEditingColor

        underlineView.backgroundColor = underlineColor
    }

    private func styleCountView(theme: Theme, displayable: TextInputDisplayable) {
        if textField.rightView == nil {
            let height = theme.constants.textInputIconFrameSideLength
            NSLayoutConstraint.activate([countView.heightAnchor.constraint(equalToConstant: height)])

            textField.rightViewMode = .always
            textField.rightView = countView
        }

        countView.styleWith(theme: theme, displayable: displayable)
    }

    // MARK: Helpers

    func manuallySetText(_ text: String) {
        guard let theme = theme else { return }

        let colors = theme.colors
        let constants = theme.constants

        textField.attributedText = text.attributed(fontStyle: constants.textInputFontStyle,
                                                   color: colors.textHighEmphasis)
    }
}

// MARK: - DetailTextField: UITextFieldDelegate

extension DetailTextField: UITextFieldDelegate {

    // MARK: Custom Overrides

    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSelected = true
        countView.styleEditing(true)
        delegate?.textFieldDidEndEditing?(textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isSelected = false
        countView.styleEditing(false)
        delegate?.textFieldDidEndEditing?(textField)
    }

    // MARK: Pass-Throughs

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldClear?(textField) ?? true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn?(textField) ?? false
    }
}

// MARK: - DetailTextField: PaddedTextFieldDelegate

extension DetailTextField: PaddedTextFieldDelegate {
    func paddedTextFieldDidDeleteBackwards(_ paddedTextField: PaddedTextField) {
        delegate?.detailTextFieldDidDeleteBackwards(textField)
    }
}

// MARK: - DetailTextField: TextInputCountViewDelegate

extension DetailTextField: TextInputCountViewDelegate {
    func textInputCountViewButtonTapped(_ textInputCountView: TextInputCountView) {
        textField.text = ""
        delegate?.detailTextFieldDidChange(textField)
    }
}
