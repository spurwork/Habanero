// MARK: - Button: UIButton

public class Button: UIButton {

    // MARK: Properties

    private var style: ButtonStyle
    private var theme: Theme?
    private var height: NSLayoutConstraint?

    internal var customSubView: UIView?

    // MARK: Initializer

    public init(frame: CGRect, style: ButtonStyle) {
        self.style = style
        super.init(frame: frame)
    }

    internal override init(frame: CGRect) {
        style = .contained(.primary)
        super.init(frame: frame)
    }

    internal required init?(coder aDecoder: NSCoder) {
        style = .contained(.primary)
        super.init(coder: aDecoder)
    }

    // MARK: UIButton

    public override var isEnabled: Bool {
        didSet {
            styleEnabled()
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            if let theme = theme {
                let constants = theme.constants
                alpha = isHighlighted ? constants.alphaDisabled : 1.0
            }
        }
    }

    public override var isSelected: Bool {
        didSet {
            if let theme = theme {
                let colors = theme.colors

                switch style {
                case .contained(let containedType):
                    containedType.styleSelected(button: self, colors: colors, selected: isSelected)
                case .menu:
                    let borderColor = isSelected ? colors.borderButtonMenuSelected : colors.borderButtonMenu
                    layer.borderColor = borderColor.cgColor
                case .outline(let outlineType):
                    outlineType.styleSelected(button: self, selected: isSelected)
                case .text(let textType, _):
                    textType.styleSelected(button: self, selected: isSelected)
                }
            }
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        guard let theme = theme else { return }

        styleEnabled()
        styleBorder(theme: theme)

        super.traitCollectionDidChange(previousTraitCollection)
    }

    // MARK: Style

    public func styleWith(theme: Theme, style: ButtonStyle) {
        var canSwapStyle = false
        switch self.style {
        case .contained:
            if case .contained = style { canSwapStyle = true }
        case .menu:
            if case .menu = style { canSwapStyle = true }
        case .outline:
            if case .outline = style { canSwapStyle = true }
        case .text:
            if case .text = style { canSwapStyle = true }
        }

        if canSwapStyle {
            self.style = style
            styleWith(theme: theme)
        }
    }

    public func styleWith(theme: Theme) {
        self.theme = theme

        if height == nil {
            height = heightAnchor.constraint(equalToConstant: theme.constants.buttonHeight)
            if let height = height {
                NSLayoutConstraint.activate([height])
            }
        }

        styleContentAlignment(theme: theme)
        styleContentEdgeInsets(theme: theme)
        styleEnabled(theme: theme, enabled: true)
        styleFontStyle(theme: theme)
        styleTitleColor(theme: theme)
        styleBorder(theme: theme)
        styleCornerRadius(theme: theme)

        if let customSubView = customSubView {
            addSubview(customSubView)
        }
    }

    private func styleContentAlignment(theme: Theme) {
        let constants = theme.constants

        switch style {
        case .menu:
            titleEdgeInsets = constants.menuButtonTitleEdgeInsets
            contentHorizontalAlignment = .left
        case .text(_, let contentHorizontalAlignment):
            self.contentHorizontalAlignment = contentHorizontalAlignment
        default: return
        }
    }

    private func styleContentEdgeInsets(theme: Theme) {
        let constants = theme.constants

        switch style {
        case .contained, .outline:
            contentEdgeInsets = constants.buttonContentEdgeInsets
        default: return
        }
    }

    private func styleEnabled() {
        if let theme = theme {
            styleEnabled(theme: theme, enabled: isEnabled)
        }
    }

    private func styleEnabled(theme: Theme, enabled: Bool) {
        let colors = theme.colors
        let constants = theme.constants

        switch style {
        case .contained(let containedType):
            containedType.styleEnabled(button: self, colors: colors, enabled: enabled)
        case .menu:
            alpha = enabled ? 1.0 : constants.alphaDisabled
            layer.borderColor = enabled ? colors.borderButtonMenu.cgColor : colors.borderButtonMenuDisabled.cgColor
        case .outline(let outlineType):
            outlineType.styleEnabled(button: self, colors: colors, enabled: enabled)
        case .text: return
        }
    }

    private func styleFontStyle(theme: Theme) {
        let constants = theme.constants

        switch style {
        case .menu:
            titleLabel?.font = FontStyle.labelSmall.font
        default:
            titleLabel?.font = FontStyle.buttonText.font
        }

        switch style {
        case .menu:
            titleLabel?.numberOfLines = 2
            titleLabel?.lineBreakMode = .byTruncatingTail
        case .text:
            titleLabel?.numberOfLines = 0
        default:
            titleLabel?.adjustsFontSizeToFitWidth = true
            titleLabel?.minimumScaleFactor = constants.buttonTextMinimumScaleFactor
        }
    }

    private func styleTitleColor(theme: Theme) {
        let colors = theme.colors

        var titleColor: UIColor = .textHighEmphasis
        switch style {
        case .contained(let containedType):
            titleColor = containedType.textColor(colors: colors)
        case .menu:
            titleColor = colors.textButtonMenuPlaceholder
        case .outline(let outlineType):
            titleColor = outlineType.textColor(colors: colors)
        case .text(let textType, _):
            titleColor = textType.textColor(colors: colors)
        }

        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor, for: .highlighted)
        setTitleColor(titleColor, for: .selected)
        setTitleColor(colors.textDisabled, for: .disabled)
    }

    private func styleBorder(theme: Theme) {
        let colors = theme.colors
        let constants = theme.constants

        switch style {
        case .menu:
            layer.borderWidth = constants.buttonBorderWidth
            layer.borderColor = colors.borderButtonMenu.cgColor
        case .outline(let outlineType):
            layer.borderWidth = constants.buttonBorderWidth
            layer.borderColor = outlineType.borderColor(colors: colors).cgColor
        case .contained(let containedType):
            customSubView = containedType.createInnerBorderView(frame: frame, theme: theme)
        case .text: return
        }
    }

    private func styleCornerRadius(theme: Theme) {
        let constants = theme.constants

        switch style {
        case .menu:
            layer.cornerRadius = constants.buttonCornerRadiusSmall
        case .outline, .contained:
            layer.cornerRadius = constants.buttonCornerRadiusStandard
        case .text: return
        }
    }
}
