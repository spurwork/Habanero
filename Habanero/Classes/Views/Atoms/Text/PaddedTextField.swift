// MARK: - PaddingTextFieldDelegate

protocol PaddedTextFieldDelegate: AnyObject {
    func paddedTextFieldDidDeleteBackwards(_ paddedTextField: PaddedTextField)
}

// MARK: - PaddedTextField: UITextField

class PaddedTextField: UITextField {

    // MARK: Properties

    private let textPadding = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)

    weak var paddedTextFieldDelegate: PaddedTextFieldDelegate?

    // MARK: UITextField

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func deleteBackward() {
        super.deleteBackward()
        paddedTextFieldDelegate?.paddedTextFieldDidDeleteBackwards(self)
    }
}
