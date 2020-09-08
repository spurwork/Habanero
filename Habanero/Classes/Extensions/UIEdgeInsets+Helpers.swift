// MARK: - UIEdgeInsets (Helpers)

extension UIEdgeInsets {
    /// Initializes `UIEdgeInsets` with equal insets for top, left, bottom, and right.
    /// - Parameter inset: The amount of inset to apply to each edge.
    public init(uniform inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// Initializes `UIEdgeInsets` with equal insets for top-and-bottom and left-and-right.
    /// - Parameters:
    ///   - vertical: The amount of inset to apply vertically.
    ///   - horizontal: The amount of inset to apply horizontally.
    public init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    /// Initializes `UIEdgeInsets` with equal insets for left-and-right, and zero for top-and-bottom.
    /// - Parameter inset: The amount of inset to apply horizontally.
    public init(horizontal inset: CGFloat) {
        self.init(vertical: 0, horizontal: inset)
    }

    /// Initializes `UIEdgeInsets` with equal insets for top-and-bottom, and zero for left-and-right.
    /// - Parameter inset: The amount of inset to apply vertically.
    public init(vertical inset: CGFloat) {
        self.init(vertical: inset, horizontal: 0)
    }
}
