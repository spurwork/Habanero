// MARK: - StatusViewDisplayable

/// An object that can be displayed by a `StatusViews`.
public protocol StatusViewDisplayable {
    /// The status string.
    var status: String { get }

    /// The status type.
    var type: StatusType { get }
}

// MARK: - StatusView: BaseView

public class StatusView: BaseView {

    // MARK: Properties

    private let dotView = UIView(frame: .zero)
    private let label = UILabel(frame: .zero)

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "label": label,
            "dotView": dotView
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[dotView]-10-[label]|",
            "V:|[label]|"
        ]
    }

    private var centerDot: NSLayoutConstraint?

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(dotView)
        addSubview(label)
    }

    // MARK: Custom Styling

    public func styleWith(theme: Theme, displayable: StatusViewDisplayable) {
        let colors = theme.colors
        let constants = theme.constants

        if centerDot == nil {
            centerDot = NSLayoutConstraint(item: dotView,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1,
                                           constant: 0)
            if let centerDot = centerDot {
                NSLayoutConstraint.activate([centerDot])
            }
        }

        let dotWidth: CGFloat = constants.statusViewDotWidth
        NSLayoutConstraint.activate([
            dotView.heightAnchor.constraint(equalToConstant: dotWidth),
            dotView.widthAnchor.constraint(equalToConstant: dotWidth)
        ])
        dotView.layer.cornerRadius = dotWidth / 2.0

        let dotColor = displayable.type.color(colors: colors)
        dotView.backgroundColor = dotColor
        dotView.layer.borderColor = dotColor.cgColor

        label.numberOfLines = 0
        label.attributedText = displayable.status.attributed(fontStyle: .bodyLarge,
                                                             color: colors.textHighEmphasis,
                                                             alignment: .left)
    }
}
