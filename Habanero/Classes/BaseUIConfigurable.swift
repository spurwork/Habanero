// MARK: - BaseUIConfigurable

public protocol BaseUIConfigurable: class {
    var visualConstraintViews: [String: AnyObject] { get }
    var visualConstraints: [String] { get }

    func addSubviews()
    func setVisualConstraints()
    func addTargets()
}
