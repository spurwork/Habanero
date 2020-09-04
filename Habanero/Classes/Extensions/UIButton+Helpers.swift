// MARK: - UIButton (Helpers)

extension UIButton {
    static func createShowMoreButton(theme: Theme, title: String) -> UIButton {
        let constants = theme.constants
        let colors = theme.colors
        let titleColor = colors.textHighEmphasis

        let button = UIButton(type: .custom)

        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: constants.expandButtonTitleCaretSpacing)

        button.titleLabel?.font = FontStyle.labelLarge.font
        button.setTitle(title, for: .normal)

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .highlighted)
        button.setTitleColor(titleColor, for: .selected)
        button.setTitleColor(colors.textDisabled, for: .disabled)

        button.tintColor = colors.tintButtonImagePrimary
        button.imageEdgeInsets = constants.expandButtonCaretImageInsets
        button.setImage(theme.images.caretDown, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        return button
    }
}
