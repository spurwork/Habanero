// MARK: - SelectionLabelDelegate

protocol SelectionLabelDelegate: AnyObject {
    func selectionLabelWasTouchedUp(_ selectionLabel: SelectionLabel)
    func selectionLabelWasTouchedDown(_ selectionLabel: SelectionLabel)
}

// MARK: - SelectionLabel: BaseControl

final class SelectionLabel: BaseControl {

    // MARK: Properties

    let label = UILabel()

    var theme: Theme?
    weak var delegate: SelectionLabelDelegate?

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside])
    }

    // MARK: UIControl

    override var isEnabled: Bool {
        didSet {
            guard let theme = theme else { return }
            let constants = theme.constants

            label.alpha = isEnabled ? 1.0 : constants.alphaDisabled
        }
    }

    // MARK: Actions

    @objc func touchDown() {
        delegate?.selectionLabelWasTouchedDown(self)
    }

    @objc func touchUp() {
        delegate?.selectionLabelWasTouchedUp(self)
    }
}
