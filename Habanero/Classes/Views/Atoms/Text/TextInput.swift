// MARK: - TextInputDelegate

public protocol TextInputDelegate: class {
    func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool
    func textInputShouldReturn(_ textInput: TextInput) -> Bool
    func textInputTextDidChange(_ textInput: TextInput, text: String)
    func textInputHasInputError(_ textInput: TextInput, error: Error)
}

// MARK: - TextInput: BaseControl

public class TextInput: BaseControl {

    // MARK: Properties

    private let stackView = UIStackView(frame: .zero)
    private let mainLabel = UILabel(frame: .zero)

    private var textInputView: UIControl?

    private let textField = DetailTextField(frame: .zero)
    private let textView = DetailTextView(frame: .zero)

    private let errorLabel = UILabel(frame: .zero)
    private let tipLabel = UILabel(frame: .zero)

    private var theme: Theme?
    private var displayable: TextInputDisplayable?

    public weak var delegate: TextInputDelegate?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "stackView": stackView
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[stackView]|",
            "V:|[stackView]|"
        ]
    }

    private var textFieldHeight: NSLayoutConstraint?
    private var underlineHeight: NSLayoutConstraint?

    public override var isEnabled: Bool {
        didSet {
            textInputView?.isEnabled = isEnabled

            if let theme = theme {
                let constants = theme.constants
                let disabledAlpha = constants.alphaDisabled
                mainLabel.alpha = isEnabled ? 1.0 : disabledAlpha
                textInputView?.alpha = isEnabled ? 1.0 : disabledAlpha
                errorLabel.alpha = isEnabled ? 1.0 : disabledAlpha
                tipLabel.alpha = isEnabled ? 1.0 : disabledAlpha
            }
        }
    }

    public override var isSelected: Bool {
        didSet {
            textField.isSelected = isSelected
            textView.isSelected = isSelected
        }
    }

    public var responder: UIResponder? {
        guard let displayable = displayable else { return nil }
        return displayable.multiline ? textView.responder : textField.responder
    }

    private var formatter: TextInputFormatter? {
        guard let displayable = displayable else { return nil }
        switch displayable.format {
        case .string(let textPattern, let patternSymbol, let allowedSymbolsRegex):
            let formatter = StringInputFormatter.shared
            formatter.reset(textPattern: textPattern,
                            patternSymbol: patternSymbol,
                            allowedSymbolsRegex: allowedSymbolsRegex)
            return formatter
        case .dollars(let maxDollars, let useCents):
            let formatter = NumberInputFormatter.shared
            formatter.reset(numberAsString: displayable.value,
                            numberStyle: .currency,
                            maxNonFractionalValue: maxDollars ?? formatter.defaultMaxNonFractionalValue,
                            showFractionalDigits: useCents)
            return formatter
        case .float(let maxWholeNumber):
            let formatter = NumberInputFormatter.shared
            formatter.reset(numberAsString: displayable.value,
                            numberStyle: .decimal,
                            maxNonFractionalValue: maxWholeNumber ?? formatter.defaultMaxNonFractionalValue,
                            showFractionalDigits: true)
            return formatter
        default:
            return nil
        }
    }

    // MARK: BaseView

    public override func addSubviews() {
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(tipLabel)
        stackView.addArrangedSubview(UIView())

        addSubview(stackView)
    }

    public override func addTargets() {
        textField.delegate = self
        textView.delegate = self
    }

    // MARK: Style

    /// Styles a `TextInput` with a `TextInputDisplayable`.
    /// - Parameter displayable: The object to use for styling.
    public func styleWith(theme: Theme, displayable: TextInputDisplayable) {
        self.theme = theme
        self.displayable = displayable

        styleStackView(theme: theme)
        styleMainLabel(theme: theme, displayable: displayable)

        // determine which input control to show
        textInputView = displayable.multiline ? textView : textField
        textInputView?.isHidden = false

        // style common elements
        styleTextInputView(theme: theme, displayable: displayable)
        styleForError(theme: theme, displayable: displayable)
        styleTipLabel(theme: theme, displayable: displayable)

        // style the input control that will be shown
        if let textField = textInputView as? DetailTextField {
            textField.styleWith(theme: theme, displayable: displayable, formatter: formatter)
            textField.isUserInteractionEnabled = displayable.editable
            textView.isHidden = true
        } else if let textView = textInputView as? DetailTextView {
            textView.styleWith(theme: theme, displayable: displayable, formatter: formatter)
            textView.isUserInteractionEnabled = displayable.editable
            textField.isHidden = true
        }
    }

    private func styleStackView(theme: Theme) {
        let constants = theme.constants

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = constants.textInputStackInsets
        stackView.spacing = constants.textInputContentVerticalSpacing
        stackView.axis = .vertical
    }

    private func styleMainLabel(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors

        mainLabel.numberOfLines = 0
        mainLabel.attributedText = displayable.label
            .uppercased().attributed(fontStyle: .h5, color: colors.textHighEmphasis)
    }

    private func styleTextInputView(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors

        textInputView?.accessibilityLabel = displayable.label
        textInputView?.tintColor = colors.tintTextInputCursor
    }

    private func styleForError(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors

        errorLabel.numberOfLines = 0
        if let error = displayable.error {
            errorLabel.isHidden = false
            errorLabel.attributedText = error.localizedDescription.attributed(fontStyle: .labelLarge,
                                                                              color: colors.textError)
        } else {
            errorLabel.isHidden = true
        }
    }

    private func styleTipLabel(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors

        tipLabel.numberOfLines = 0

        if let tip = displayable.tip {
            tipLabel.isHidden = false
            tipLabel.attributedText = tip.attributed(fontStyle: .labelLarge, color: colors.textInputTip)
        } else {
            tipLabel.isHidden = true
        }
    }

    // MARK: Helpers

    public func manuallySetText(_ text: String) {
        textField.manuallySetText(text)
        textView.manuallySetText(text)
    }

    private func updatedTextWithoutFormatter(currentText: String,
                                             shouldChangeCharactersIn range: NSRange,
                                             replacementString string: String) -> String {
        let currentNSString = NSString(string: currentText)
        return currentNSString.replacingCharacters(in: range, with: string)
    }
}

// MARK: - TextInput: DetailTextFieldDelegate

extension TextInput: DetailTextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.textInputShouldBeginEditing(self) ?? true
    }

    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        guard let theme = theme, let displayable = displayable else { return false }

        // don't allow changes to exceed the maximum length
        let currentCount = formatter?.unformatText(textField.text)?.count ?? textField.text?.count ?? 0
        let maxCount = displayable.customCharacterCount(constants: theme.constants)
        guard (currentCount + string.count) <= maxCount else {
            delegate?.textInputHasInputError(self, error: TextInputError.cannotExceedCharacterCount(maxCount))
            return false
        }

        if let formatter = formatter {
            // capture copy of text before mutating function
            let originalText = textField.text
            formatter.applyFormatToTextField(textField, shouldChangeCharactersIn: range, textToAdd: string)

            if originalText != textField.text {
                // text is not updated with normal `UITextField` flow, so tell the delegate
                let finalUnformattedText = formatter.unformatText(textField.text) ?? ""
                delegate?.textInputTextDidChange(self, text: finalUnformattedText)
            }
        } else {
            // update text manually
            let finalText = updatedTextWithoutFormatter(currentText: textField.text ?? "",
                                                        shouldChangeCharactersIn: range,
                                                        replacementString: string)

            textField.text = finalText
            textField.adjustCursorForOriginalRange(range, replacementText: string)

            delegate?.textInputTextDidChange(self, text: finalText)
        }

        return false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textInputShouldReturn(self) ?? false
    }

    public func detailTextFieldDidChange(_ textField: UITextField) {
        delegate?.textInputTextDidChange(self, text: textField.text ?? "")
    }

    public func detailTextFieldDidDeleteBackwards(_ textField: UITextField) {
        delegate?.textInputHasInputError(self, error: TextInputError.deletingWhileEmpty)
    }
}

// MARK: - TextInput: DetailTextViewDelegate

extension TextInput: DetailTextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return delegate?.textInputShouldBeginEditing(self) ?? true
    }

    public func textView(_ textView: UITextView,
                         shouldChangeTextIn range: NSRange,
                         replacementText text: String) -> Bool {
        guard let theme = theme, let displayable = displayable else { return false }

        // don't allow changes to exceed the maximum length
        let currentCount = formatter?.unformatText(textView.text)?.count ?? textView.text.count
        let maxCount = displayable.customCharacterCount(constants: theme.constants)
        guard (currentCount + text.count) <= maxCount else {
            delegate?.textInputHasInputError(self, error: TextInputError.cannotExceedCharacterCount(maxCount))
            return false
        }

        // trying to delete while empty
        guard !(textView.text.isEmpty && text.isEmpty) else {
            delegate?.textInputHasInputError(self, error: TextInputError.deletingWhileEmpty)
            return false
        }

        if let formatter = formatter {
            // capture copy of text before mutating function
            let originalText = textView.text
            formatter.applyFormatToTextView(textView, shouldChangeCharactersIn: range, textToAdd: text)

            if originalText != textView.text {
                // text is not updated with normal `UITextView` flow, so tell the delegate
                let finalUnformattedText = formatter.unformatText(textView.text) ?? ""
                delegate?.textInputTextDidChange(self, text: finalUnformattedText)
            }
        } else {
            // update text manually
            let finalText = updatedTextWithoutFormatter(currentText: textView.text,
                                                        shouldChangeCharactersIn: range,
                                                        replacementString: text)

            textView.text = finalText
            textView.adjustCursorForOriginalRange(range, replacementText: text)

            delegate?.textInputTextDidChange(self, text: finalText)
        }

        return false
    }

    public func textViewDidChange(_ textView: UITextView) {
        delegate?.textInputTextDidChange(self, text: textView.text)
    }

    public func detailTextViewDidDeleteBackwards(_ textView: UITextView) {
        delegate?.textInputHasInputError(self, error: TextInputError.deletingWhileEmpty)
    }
}
