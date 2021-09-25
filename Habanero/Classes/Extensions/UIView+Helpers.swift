// MARK: - UIView (Helpers)

public extension UIView {
    /// Shakes the view back-and-forth horizontally.
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 2, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 2, y: center.y))

        layer.add(animation, forKey: "position")
    }

    /// Returns an anchor point within a view.
    /// - Parameters:
    ///   - view: The view whose anchor point will be returned.
    ///   - theme: Provides layout values for things like padding.
    ///   - anchorPoint: Determines the anchor point used within the `view`.
    /// - Returns: An anchor point.
    func anchor(onView view: UIView, withTheme theme: Theme, atAnchorPoint anchorPoint: AnchorPoint) -> CGPoint {
        let constants = theme.constants

        switch anchorPoint {
        case .top:
            let topPadding: CGFloat = constants.anchorTopExtraVerticalPadding + view.safeAreaInsets.top
            return CGPoint(x: view.bounds.size.width / 2.0,
                           y: (frame.size.height / 2) + topPadding)
        case .center:
            return CGPoint(x: view.bounds.size.width / 2.0,
                           y: view.bounds.size.height / 2.0)
        case .bottom:
            let bottomPadding: CGFloat = constants.anchorBottomExtraVerticalPadding + view.safeAreaInsets.bottom
            return CGPoint(x: view.bounds.size.width / 2.0,
                           y: view.bounds.size.height - (frame.size.height / 2) - bottomPadding)
        }
    }

    /// Returns an anchor point within a view. Anchor will be adjusted based on the size of `self` to attempt
    /// to keep the view in the visible area, as close to the `atPoint` location as possible.
    /// - Parameters:
    ///   - onSubview: The `view` around which to anchor `self`.
    ///   - view: The parent view used to calculate the final anchor point.
    ///   - withAnchor: Calculate final anchor to position the `self` above, inline with, or below the `subview`.
    ///   - theme: Provides layout values for things like padding.
    /// - Returns: An anchor point.
    func anchor(onSubview subview: UIView,
                inSuperview superview: UIView,
                withAnchor anchor: AnchorPoint?,
                withTheme theme: Theme) -> CGPoint {
        let constants = theme.constants

        var centerPosition = superview.convert(subview.center, from: subview.superview)
        let anchor = anchor ?? (centerPosition.y > superview.bounds.midY ? .top : .bottom)

        switch anchor {
        case .top:
            centerPosition.y -= subview.frame.height / 2
            centerPosition.y -= frame.height / 2
        case .center:
            break
        case .bottom:
            centerPosition.y += subview.frame.height / 2
            centerPosition.y += frame.height / 2
        }

        centerPosition.x = max(centerPosition.x,
                               superview.bounds.minX + frame.width/2 + constants.minimumAnchoredViewSideInset)
        centerPosition.x = min(centerPosition.x,
                               superview.bounds.maxX - frame.width/2 - constants.minimumAnchoredViewSideInset)

        return centerPosition
    }

    /// Adds visually-specified constaints to the view.
    /// - Parameters:
    ///   - visualConstraintViews: A dictionary mapping identifiers to items that can be used for making constraints.
    ///   - visualConstraints: An array of constraints defined using Apple's Auto Layout Visual Format Language.
    func addVisualConstraints(visualConstraintViews: [String: AnyObject], visualConstraints: [String]) {
        // NOTE: The autoresizing mask constraints fully specify the view’s size and position.
        // You cannot add additional constraints to modify the size or position without introducing conflicts.
        for value in visualConstraintViews.values {
            if let view = value as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }

        for visualFormatConstraint in visualConstraints {
            let visualConstraints = NSLayoutConstraint.constraints(withVisualFormat: visualFormatConstraint,
                                                                   options: NSLayoutConstraint.FormatOptions(),
                                                                   metrics: nil,
                                                                   views: visualConstraintViews)

            // SOURCE: aplus.rs/2017/one-solution-for-90pct-auto-layout/
            _ = visualConstraints.map { $0.priority = UILayoutPriority(rawValue: 999) }

            NSLayoutConstraint.activate(visualConstraints)
        }
    }
}
