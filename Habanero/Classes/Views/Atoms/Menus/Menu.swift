// MARK: - MenuDisplayable: MenuPickerDisplayable

/// An object that can be displayed by a `Menu`.
public protocol MenuDisplayable: MenuPickerDisplayable, SelectionGroupDisplayable {
    /// The currently selected value displayed on the `Menu`.
    var selectedValue: String? { get }

    /// A value to display on the `Menu` button when the `selectedValue` is equal to `nil`.
    var placeholder: String { get }
}

// MARK: - Menu: BaseView

/// A design element that can display a selected value from a set of possible values.
/// Under the hood, this element is implemented as a `Button` that can invoke a picker
/// element that allows the user to select a new value.
public class Menu: BaseView {

    // MARK: Properties

    private let menuButton = Button(frame: .zero, style: .menu)

    private var theme: Theme?
    private var displayable: MenuDisplayable?
    private let presentingVC: UIViewController?

    public weak var pickerDelegate: MenuPickerDelegate?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "menuButton": menuButton
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[menuButton]|",
            "V:|[menuButton]|"
        ]
    }

    // MARK: Initializer

    public init(frame: CGRect, tag: Int, presentingVC: UIViewController?) {
        self.presentingVC = presentingVC
        super.init(frame: frame)
        menuButton.tag = tag
    }

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(menuButton)
    }

    public override func addTargets() {
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        styleTitleColor()
    }

    // MARK: Actions

    @objc private func menuButtonTapped() {
        guard let theme = theme,
            let displayable = displayable,
            let presentingVC = presentingVC,
            let pickerDelegate = pickerDelegate else { return }

        MenuPicker.shared.show(theme: theme,
                               displayable: displayable,
                               delegate: pickerDelegate,
                               presentingVC: presentingVC,
                               tag: menuButton.tag,
                               menu: self)
    }

    // MARK: Style

    public func styleWith(theme: Theme, displayable: MenuDisplayable) {
        self.theme = theme
        self.displayable = displayable

        menuButton.styleWith(theme: theme)
        menuButton.setTitle(displayable.selectedValue ?? displayable.placeholder, for: .normal)
        styleTitleColor()

        menuButton.isEnabled = displayable.isEnabled
    }

    private func styleTitleColor() {
        guard let theme = theme, let displayable = displayable else { return }

        let colors = theme.colors
        let titleColor = displayable.selectedValue == nil ?
            colors.textButtonMenuPlaceholder : colors.textButtonMenuSelected

        menuButton.setTitleColor(titleColor, for: .normal)
        menuButton.setTitleColor(titleColor, for: .highlighted)
        menuButton.setTitleColor(titleColor, for: .selected)
        menuButton.setTitleColor(colors.textDisabled, for: .disabled)
    }
}
