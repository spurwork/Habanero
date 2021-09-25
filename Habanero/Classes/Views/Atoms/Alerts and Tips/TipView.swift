// MARK: - TipViewDelegate

protocol TipViewDelegate: class {
    func tipViewShouldDismiss(_ tipView: TipView)
}

// MARK: - TipViewDisplayable

/// An object that can be displayed by a `TipView`.
public protocol TipViewDisplayable {
    /// The message string.
    var message: String { get }

    /// The duration to show the tip.
    var duration: Double? { get }

    /// The position where the tip should be connected to its presenting view.
    var anchor: AnchorPoint? { get }
}

// MARK: - TipView: BaseView

public class TipView: BaseView {

    // MARK: Properties

    private let stackView = UIStackView(frame: .zero)

    private let messageLabel = UILabel(frame: .zero)

    private let button = UIButton(type: .custom)

    weak var delegate: TipViewDelegate?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "stackView": stackView,
            "button": button
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[stackView]|",
            "V:|[stackView]|",
            "H:|[button]|",
            "V:|[button]|"
        ]
    }

    // MARK: BaseView

    public override func addSubviews() {
        stackView.addArrangedSubview(messageLabel)

        addSubview(stackView)
        addSubview(button)
    }

    public override func addTargets() {
        button.addTarget(self, action: #selector(viewTapped), for: .touchUpInside)
    }

    // MARK: Actions

    @objc func viewTapped() {
        delegate?.tipViewShouldDismiss(self)
    }

    // MARK: Style

    func calculatedHeight(theme: Theme, tipViewWidth: CGFloat) -> CGFloat {
        let constants = theme.constants
        let insets: UIEdgeInsets = constants.tipViewInsets

        let messageOnlyWidth = tipViewWidth
            - insets.left
            - insets.right

        let messageHeight = (messageLabel.attributedText?.height(withWidth: messageOnlyWidth) ?? 0) * 1.15

        return insets.top + messageHeight + insets.bottom
    }

    func singleLineWidth(theme: Theme) -> CGFloat {
        let constants = theme.constants
        let insets: UIEdgeInsets = constants.tipViewInsets

        let textWidth = messageLabel.attributedText?.size().width ?? .greatestFiniteMagnitude
        return insets.left + textWidth * 1.15 + insets.right
    }

    public func styleWith(theme: Theme, displayable: TipViewDisplayable) {
        let colors = theme.colors
        let constants = theme.constants

        stackView.layer.zPosition = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = constants.tipViewInsets
        stackView.spacing = constants.alertViewContentSpacing

        backgroundColor = colors.backgroundAlert
        layer.cornerRadius = constants.alertViewCornerRadius

        messageLabel.numberOfLines = 0
        messageLabel.attributedText = displayable.message.attributed(fontStyle: .bodyLarge,
                                                                     color: colors.textHighEmphasisInverted)
    }
}
