// MARK: - SelectionControlButtonDelegate

/// An object that can respond to events emitted by a `SelectionControlButton`.
protocol SelectionControlButtonDelegate: AnyObject {
    func selectionControlButtonWasTapped(_ button: UIButton)
}

// MARK: - SelectionControlButton: UIButton

/// An object that is a selection control button.
protocol SelectionControlButton: UIButton {
    var delegate: SelectionControlButtonDelegate? { get set }

    func styleWith(theme: Theme)
    func stylePressed(theme: Theme, pressed: Bool)
}
