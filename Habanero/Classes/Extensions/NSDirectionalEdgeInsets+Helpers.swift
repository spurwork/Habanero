// MARK: - NSDirectionalEdgeInsets (Helpers)

extension NSDirectionalEdgeInsets {
    /// Initializes `NSDirectionalEdgeInsets` with equal insets for top, leading, bottom, and trailing.
    /// - Parameter inset: The amount of inset to apply to each edge.
    public init(uniform inset: CGFloat) {
        self.init(top: inset, leading: inset, bottom: inset, trailing: inset)
    }

    /// Initializes `NSDirectionalEdgeInsets` with equal insets for leading and trailing, and zero for top and bottom.
    /// - Parameter inset: The amount of inset to apply horizontally.
    public init(horizontal inset: CGFloat) {
        self.init(top: 0, leading: inset, bottom: 0, trailing: inset)
    }

    /// Initializes `NSDirectionalEdgeInsets` with equal insets for top and bottom, and zero for leading and trailing.
    /// - Parameter inset: The amount of inset to apply vertically.
    public init(vertical inset: CGFloat) {
        self.init(top: inset, leading: 0, bottom: inset, trailing: 0)
    }
}
