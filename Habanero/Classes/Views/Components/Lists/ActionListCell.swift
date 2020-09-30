// MARK: - ActionListCellDisplayable

/// An object that can be displayed by a `ActionListCell`.
public protocol ActionListCellDisplayable {
    /// The icon displayed alongside the title and subtitle in the cell.
    var icon: UIImage? { get }

    /// The title displayed in the cell.
    var title: String { get }

    /// The subtitle displayed in the cell.
    var subtitle: String? { get }

    /// The style of the accessory view for the cell.
    var accessoryStyle: ActionListAccessoryViews { get }

    /// A custom tint color to apply to the icon.
    var customIconTintColor: UIColor? { get }

    /// A custom text color to apply to the title.
    var customTitleTextColor: UIColor? { get }

    /// A custom background color to apply to the cell.
    var customBackgroundColor: UIColor? { get }
}

// MARK: - ActionListCell: BaseTableViewCell

public class ActionListCell: BaseTableViewCell {

    // MARK: Properties

    var accessoryStatusView: StatusView?
    var accessoryDetailLabel: UILabel?
    var accessoryImageView: UIImageView?

    var accessoryStackView: UIStackView?

    // MARK: Initializer

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    // MARK: Style

    public override func styleWith(theme: Theme) {
        super.styleWith(theme: theme)

        let colors = theme.colors
        let constants = theme.constants

        let tintColor = colors.tintActionListIcon
        let imageSize = constants.actionListAccessoryImageSize

        // style known subviews
        imageView?.tintColor = tintColor
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0

        // style accessory views
        if (accessoryView as? UIStackView) != nil {
            styleAccessoryView(theme: theme)
        } else {
            accessoryStatusView = StatusView(frame: .zero)
            accessoryDetailLabel = UILabel(frame: .zero)
            accessoryImageView = UIImageView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: imageSize.width,
                                                           height: imageSize.height))

            accessoryStackView = UIStackView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: constants.actionListAccessoryDetailAndImageWidth,
                                                           height: frame.height))

            accessoryStackView?.addArrangedSubview(accessoryStatusView ?? StatusView())
            accessoryStackView?.addArrangedSubview(accessoryDetailLabel ?? UILabel())
            accessoryStackView?.addArrangedSubview(accessoryImageView ?? UIImageView())

            if let detailWidthMininum = accessoryDetailLabel?.widthAnchor
                .constraint(greaterThanOrEqualToConstant: constants.actionListAccessoryDetailMinimumWidth),
                let accessoryImageWidth = accessoryImageView?.widthAnchor
                    .constraint(equalToConstant: imageSize.width) {
                NSLayoutConstraint.activate([detailWidthMininum, accessoryImageWidth])
            }

            styleAccessoryView(theme: theme)

            accessoryView = accessoryStackView
        }
    }

    public func styleWith(theme: Theme, displayable: ActionListCellDisplayable) {
        let colors = theme.colors
        let constants = theme.constants
        let textColor = colors.textHighEmphasis

        // adjust frame based on accessory style
        if let previousAccessoryFrame = accessoryView?.frame {
            accessoryView?.frame = CGRect(x: 0,
                                          y: 0,
                                          width: displayable.accessoryStyle.totalWidth(constants: constants),
                                          height: previousAccessoryFrame.height)
        }

        // background
        backgroundColor = displayable.customBackgroundColor ?? colors.backgroundCell

        // icon
        imageView?.image = displayable.icon
        imageView?.tintColor = displayable.customIconTintColor ?? colors.tintActionListIcon

        // title
        let titleTextColor = displayable.customTitleTextColor ?? textColor
        textLabel?.attributedText = displayable.title.attributed(fontStyle: .h5, color: titleTextColor)

        // subtitle
        let subtitle = displayable.subtitle ?? ""
        detailTextLabel?.attributedText = subtitle.attributed(fontStyle: .bodyLarge, color: textColor)

        // detail
        let detailDisplayable = displayable.accessoryStyle.detailDisplayable
        let detailString = detailDisplayable?.detail ?? ""
        let detailTextColor = detailDisplayable?.customTextColor ?? textColor
        accessoryDetailLabel?.attributedText = detailString.attributed(fontStyle: .bodyLarge,
                                                                       color: detailTextColor,
                                                                       alignment: .right)

        // acccessory views
        accessoryDetailLabel?.isHidden = detailString.isEmpty
        switch displayable.accessoryStyle {
        case .detailOnly:
            accessoryStatusView?.isHidden = true
            accessoryImageView?.isHidden = true
            accessoryView = detailString.isEmpty ? nil : accessoryStackView
        case .detailAndNavigation(_, let navigationStyle):
            accessoryStatusView?.isHidden = true
            accessoryImageView?.isHidden = false
            accessoryImageView?.image = navigationStyle.icon(images: theme.images)
            accessoryView = (detailString.isEmpty && navigationStyle == .none) ? nil : accessoryStackView
        case .statusAndDetail(let displayable, _):
            accessoryStatusView?.isHidden = false
            accessoryImageView?.isHidden = true
            accessoryStatusView?.styleWith(theme: theme, displayable: displayable)
            accessoryView = accessoryStackView
        case .none:
            accessoryView = nil
        }
    }

    private func styleAccessoryView(theme: Theme) {
        let colors = theme.colors
        let constants = theme.constants
        let images = theme.images

        let tintColor = colors.tintActionListIcon

        accessoryStatusView?.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        accessoryStatusView?.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        accessoryDetailLabel?.numberOfLines = 0
        accessoryDetailLabel?.textAlignment = .right
        accessoryDetailLabel?.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        accessoryDetailLabel?.setContentHuggingPriority(.defaultLow, for: .horizontal)

        accessoryImageView?.contentMode = .scaleAspectFit
        accessoryImageView?.image = images.caretRight
        accessoryImageView?.tintColor = tintColor
        accessoryImageView?.setContentHuggingPriority(UILayoutPriority(900), for: .horizontal)

        accessoryStackView?.distribution = .fill
        accessoryStackView?.spacing = constants.actionListAccessoryViewSpacing
    }
}
