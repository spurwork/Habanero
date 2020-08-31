// MARK: - UIStackView (Helpers)

// SOURCE: gist.github.com/yasirmturk/0b47d18a30722902a9a4aaad05d1794a
extension UIStackView {
    /// Removes all arranged subviews from a `UIStackView`. Each arranged subview's constraints can be
    /// deactivated, and each arranged subview is removed from its superview.
    /// - Parameter deactivateConstraints: Should each subview's constraints be deactivated?
    /// - Returns: All arrange subviews that have been removed from this `UIStackView`.
    @discardableResult
    public func removeAllArrangedSubviews(deactivateConstraints: Bool = true) -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) {
            $0 + [removeArrangedSubViewProperly($1, deactivateConstraints: deactivateConstraints)]
        }
    }

    private func removeArrangedSubViewProperly(_ view: UIView, deactivateConstraints: Bool) -> UIView {
        removeArrangedSubview(view)
        if deactivateConstraints { NSLayoutConstraint.deactivate(view.constraints) }
        (view as? UIControl)?.removeTarget(nil, action: nil, for: .allEvents)
        view.removeFromSuperview()
        return view
    }
}
