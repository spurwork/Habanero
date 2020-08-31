// MARK: - BaseTableViewCell: UITableViewCell, BaseUIConfigurable

/// A `UITableViewCell` with known injection points for visually formatted Auto Layout constraints,
/// adding subviews, and adding subview targets/actions.
open class BaseTableViewCell: UITableViewCell, BaseUIConfigurable {

    // MARK: Properties

    var theme: Theme?

    open var visualConstraintViews: [String: AnyObject] { return [:] }
    open var visualConstraints: [String] { return [] }

    // MARK: Initializer

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        setVisualConstraints()
        addTargets()
    }

    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Style

    open func styleWith(theme: Theme) {
        self.theme = theme

        let colors = theme.colors

        backgroundColor = colors.backgroundCell

        let selectedColorView = UIView(frame: bounds)
        selectedColorView.backgroundColor = colors.backgroundCellPressed
        selectedBackgroundView = selectedColorView
    }

    open func styleEnabled(theme: Theme, enabled: Bool) {
        let constants = theme.constants
        alpha = enabled ? 1.0 : constants.alphaDisabled
    }

    // MARK: BaseUIConfigurable

    open func addSubviews() {}

    final public func setVisualConstraints() {
        addVisualConstraints(visualConstraintViews: visualConstraintViews, visualConstraints: visualConstraints)
    }

    open func addTargets() {}
}
