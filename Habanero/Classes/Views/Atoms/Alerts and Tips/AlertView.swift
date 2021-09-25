// MARK: - AlertViewDelegate

protocol AlertViewDelegate: class {
    func alertViewShouldDismiss(_ alertView: AlertView)
}

// MARK: - AlertViewDisplayable

/// An object that can be displayed by an `AlertView`.
public protocol AlertViewDisplayable {
    /// The message string.
    var message: String { get }

    /// The alert type.
    var type: AlertType { get }

    /// The duration to show the alert.
    var duration: Double { get }

    /// The position where the alert should be anchored to its containing view.
    var anchor: AnchorPoint { get }
}

// MARK: - AlertView: BaseView

public class AlertView: BaseView {

    // MARK: Properties

    private let stackView = UIStackView(frame: .zero)

    private let iconImageView = UIImageView(frame: .zero)
    private let messageLabel = UILabel(frame: .zero)
    private let closeButton = UIButton(type: .system)

    weak var delegate: AlertViewDelegate?

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

    // MARK: BaseView

    public override func addSubviews() {
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(closeButton)

        addSubview(stackView)
    }

    public override func addTargets() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    // MARK: Actions

    @objc func closeButtonTapped() {
        delegate?.alertViewShouldDismiss(self)
    }

    // MARK: Style

    func calculatedHeight(theme: Theme, alertViewWidth: CGFloat) -> CGFloat {
        let constants = theme.constants
        let insets = constants.alertViewInsets

        let messageOnlyWidth = alertViewWidth
            - insets.left
            - insets.right
            - constants.alertViewIconWidth
            - constants.alertViewCloseButtonWidth
            - (stackView.spacing * 2)
        let messageHeight = (messageLabel.attributedText?.height(withWidth: messageOnlyWidth) ?? 0) * 1.15

        let iconHeight = constants.alertViewIconWidth

        let greatestSubviewHeight = (messageHeight > iconHeight) ? messageHeight : iconHeight

        return insets.top + greatestSubviewHeight + insets.bottom
    }

    public func styleWith(theme: Theme, displayable: AlertViewDisplayable) {
        let colors = theme.colors
        let constants = theme.constants
        let images = theme.images
        let alertType = displayable.type

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: constants.alertViewIconWidth),
            closeButton.widthAnchor.constraint(equalToConstant: constants.alertViewCloseButtonWidth)
        ])

        stackView.layer.zPosition = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = constants.alertViewInsets
        stackView.spacing = constants.alertViewContentSpacing

        backgroundColor = colors.backgroundAlert
        layer.cornerRadius = constants.alertViewCornerRadius

        iconImageView.image = alertType.icon(images: images)
        iconImageView.tintColor = alertType.color(colors: colors)
        iconImageView.contentMode = .scaleAspectFit

        messageLabel.numberOfLines = 0
        messageLabel.attributedText = displayable.message.attributed(fontStyle: .bodyLarge,
                                                                     color: colors.textHighEmphasisInverted)

        closeButton.tintColor = colors.tintAlertCloseButton
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.setImage(images.close, for: .normal)
    }
}
