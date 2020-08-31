// MARK: - UITableView (Helpers)

extension UITableView {
    /// Registers a `BaseTableViewCell` for reuse.
    /// - Parameter _: The type of `BaseTableViewCell` to register.
    public func registerCellWithType<T: BaseTableViewCell>(_: T.Type) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        register(T.self, forCellReuseIdentifier: className)
    }

    /// Dequeues a reusable `BaseTableViewCell`.
    /// - Parameters:
    ///   - indexPath: The index path specifying the location of the cell.
    ///   - theme: The theme used for styling of the cell.
    /// - Returns: A reusable `BaseTableViewCell`.
    public func dequeueReusableCellWithExplicitType<T: BaseTableViewCell>(forIndexPath indexPath: IndexPath,
                                                                          theme: Theme) -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""

        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("could not dequeue cell with identifier: \(className)")
        }

        cell.styleWith(theme: theme)

        return cell
    }

    /// Registers a `UITableViewHeaderFooterView` for reuse.
    public func registerHeaderFooterViewWithType<T: UITableViewHeaderFooterView>(_: T.Type) {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        register(T.self, forHeaderFooterViewReuseIdentifier: className)
    }

    /// Dequeues a reusable `UITableViewHeaderFooterView`.
    /// - Returns: A reusable `UITableViewHeaderFooterView`.
    public func dequeueReusableHeaderFooterViewWithExplicitType<T: UITableViewHeaderFooterView>() -> T {
        let className = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: className) as? T else {
            fatalError("could not dequeue header footer view with identifier: \(className)")
        }
        return view
    }
}
