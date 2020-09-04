// MARK: - SimpleSelectionControl: SelectionControlDisplayable

struct SimpleSelectionControl: SelectionControlDisplayable {

    // MARK: Properties

    let title: String

    let tip: String?
    let tipLinkable: Bool

    let isSelected: Bool
    let isEnabled: Bool
}
