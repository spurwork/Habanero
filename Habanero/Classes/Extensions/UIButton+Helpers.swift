// MARK: - UIButton (Helpers)

extension UIButton {
    static func createShowMoreButton(theme: Theme, title: String) -> UIButton {
        let constants = theme.constants
        let colors = theme.colors

        let button = UIButton(type: .custom)

        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: constants.expandButtonTitleCaretSpacing)
        button.tintColor = colors.textHighEmphasis
        button.titleLabel?.font = FontStyle.labelLarge.font
        button.setTitle(title, for: .normal)
        button.setTitleColor(colors.textHighEmphasis, for: .normal)
        button.imageEdgeInsets = constants.expandButtonCaretImageInsets
        button.setImage(theme.images.caretDown, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        return button
    }
}
