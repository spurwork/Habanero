// MARK: - DetailTextViewDelegate: UITextViewDelegate

protocol DetailTextViewDelegate: UITextViewDelegate {
    func detailTextViewDidDeleteBackwards(_ textView: UITextView)
}

// MARK: - DetailTextView: BaseControl

class DetailTextView: BaseControl {

    // MARK: Properties

    private let textView = UITextView(frame: .zero, textContainer: nil)
    private let countView = TextInputCountView(frame: .zero)

    private var theme: Theme?
    private var displayable: TextInputDisplayable?

    private var isEditing: Bool = false

    weak var delegate: DetailTextViewDelegate?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "textView": textView,
            "countView": countView
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[textView]|",
            "V:|[textView]|"
        ]
    }

    private var textViewHeight: NSLayoutConstraint?
    private var countViewTrailingEdge: NSLayoutConstraint?
    private var countViewBottomEdge: NSLayoutConstraint?

    public var responder: UIResponder { return textView }

    public override var isSelected: Bool {
        didSet {
            if let theme = theme {
                let colors = theme.colors

                let currentSelectedColor = (displayable?.error == nil)
                    ? colors.colorTextInputNormal : colors.colorTextInputError
                let newSelectedColor = isSelected
                    ? colors.colorTextInputSelected : currentSelectedColor

                textView.layer.borderColor = newSelectedColor.cgColor
            }
        }
    }

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(textView)
        addSubview(countView)
    }

    public override func addTargets() {
        textView.delegate = self
        countView.delegate = self
    }

    // MARK: Style

    public func styleWith(theme: Theme, displayable: TextInputDisplayable, formatter: TextInputFormatter?) {
        self.theme = theme
        self.displayable = displayable

        styleTextView(theme: theme, displayable: displayable, formatter: formatter)
        styleCountView(theme: theme, displayable: displayable)
        styleForError(theme: theme, displayable: displayable)
    }

    private func styleTextView(theme: Theme, displayable: TextInputDisplayable, formatter: TextInputFormatter?) {
        let colors = theme.colors
        let constants = theme.constants

        if textViewHeight == nil {
            textViewHeight = NSLayoutConstraint(item: textView,
                                                attribute: .height,
                                                relatedBy: .equal,
                                                toItem: nil,
                                                attribute: .notAnAttribute,
                                                multiplier: 1,
                                                constant: constants.detailTextViewHeight)
            if let textViewHeight = textViewHeight {
                NSLayoutConstraint.activate([textViewHeight])
            }
        }

        let fontStyle = constants.textInputFontStyle
        textView.font = fontStyle.font
        textView.layer.borderWidth = constants.detailTextViewBorderWidth
        textView.layer.cornerRadius = constants.detailTextViewCornerRadius
        textView.textContainerInset = constants.detailTextViewInsets(showCharacterCount: displayable.showCharacterCount)
        textView.isSecureTextEntry = displayable.useSecureTextEntry
        textView.keyboardType = displayable.keyboardType
        textView.textContentType = displayable.textContentType
        textView.autocorrectionType = displayable.autocorrectionType
        textView.autocapitalizationType = displayable.autocapitalizationType

        if let placeholder = displayable.placeholder, displayable.value.isEmpty, !isEditing {
            textView.attributedText = placeholder.attributed(fontStyle: fontStyle,
                                                             color: colors.textInputPlaceholder)
        } else {
            if let formatter = formatter, let formattedText = formatter.formatText(displayable.value) {
                textView.attributedText = formattedText.attributed(fontStyle: fontStyle,
                                                                   color: colors.textHighEmphasis)
            } else {
                textView.attributedText = displayable.value.attributed(fontStyle: fontStyle,
                                                                       color: colors.textHighEmphasis)
            }
        }
    }

    private func styleForError(theme: Theme, displayable: TextInputDisplayable) {
        let colors = theme.colors

        let nonEditingColor = (displayable.error == nil) ?
            colors.colorTextInputNormal : colors.colorTextInputError
        let borderColor = isEditing ? colors.colorTextInputSelected : nonEditingColor

        textView.layer.borderColor = borderColor.cgColor
    }

    private func styleCountView(theme: Theme, displayable: TextInputDisplayable) {
        let constants = theme.constants

        if countViewTrailingEdge == nil && countViewBottomEdge == nil {
            let edgeInset = -constants.detailTextViewCountInset
            countViewTrailingEdge = NSLayoutConstraint(item: countView,
                                                       attribute: .trailing,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .trailing,
                                                       multiplier: 1,
                                                       constant: edgeInset)
            countViewBottomEdge = NSLayoutConstraint(item: countView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self,
                                                     attribute: .bottom,
                                                     multiplier: 1,
                                                     constant: edgeInset)
            if let countViewTrailingEdge = countViewTrailingEdge, let countViewBottomEdge = countViewBottomEdge {
                NSLayoutConstraint.activate([
                    countViewTrailingEdge,
                    countViewBottomEdge,
                    countView.heightAnchor.constraint(equalToConstant: constants.textInputIconFrameSideLength)
                ])
            }
        }

        countView.styleWith(theme: theme, displayable: displayable)
    }

    // MARK: Helpers

    func manuallySetText(_ text: String) {
        guard let theme = theme else { return }

        let colors = theme.colors
        let constants = theme.constants

        textView.attributedText = text.attributed(fontStyle: constants.textInputFontStyle,
                                                  color: colors.textHighEmphasis)
    }
}

// MARK: - DetailTextView: UITextViewDelegate

extension DetailTextView: UITextViewDelegate {

    // MARK: Custom Overrides

    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let theme = theme, let displayable = displayable else { return }

        let colors = theme.colors

        // if placeholder text is shown, then clear it for the user
        if let placeholder = displayable.placeholder, textView.text == placeholder {
            textView.text = ""
            textView.textColor = colors.textHighEmphasis
        }

        countView.styleEditing(true)
        isSelected = true
        isEditing = true
        delegate?.textViewDidBeginEditing?(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        guard let theme = theme, let displayable = displayable else { return }

        let colors = theme.colors

        // if text is empty, then show the placeholder
        if let placeholder = displayable.placeholder, textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = colors.textInputPlaceholder
        }

        countView.styleEditing(false)
        isSelected = false
        isEditing = false
        delegate?.textViewDidEndEditing?(textView)
    }

    func textViewDidChange(_ textView: UITextView) {
        countView.styleEditing(true)
        delegate?.textViewDidChange?(textView)
    }

    // MARK: Pass-Throughs

    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return delegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return delegate?.textViewShouldBeginEditing?(textView) ?? true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return delegate?.textViewShouldEndEditing?(textView) ?? true
    }
}

// MARK: - DetailTextView: TextInputCountViewDelegate

extension DetailTextView: TextInputCountViewDelegate {
    func textInputCountViewButtonTapped(_ textInputCountView: TextInputCountView) {
        textView.text = ""
        delegate?.textViewDidChange?(textView)
    }
}
