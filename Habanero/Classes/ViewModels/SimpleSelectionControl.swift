// MARK: - SimpleSelectionControl: SelectionControlDisplayable

struct SimpleSelectionControl: SelectionControlDisplayable {

    // MARK: Properties

    let title: String
    let tip: String?
    let tipLinkable: Bool
    let isSelected: Bool
    let isEnabled: Bool

    // MARK: Initializer

    init(title: String, tip: String?, tipLinkable: Bool, isSelected: Bool, isEnabled: Bool) {
        self.title = title
        self.tip = tip
        self.tipLinkable = tipLinkable
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }

    init(toggle: SelectionControlDisplayable) {
        title = toggle.title
        tip = toggle.tip
        tipLinkable = toggle.tipLinkable
        isSelected = !toggle.isSelected
        isEnabled = toggle.isEnabled
    }
}
