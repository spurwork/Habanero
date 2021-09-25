// MARK: - BaseUIConfigurable

public protocol BaseUIConfigurable: AnyObject {
    var visualConstraintViews: [String: AnyObject] { get }
    var visualConstraints: [String] { get }

    func addSubviews()
    func setVisualConstraints()
    func addTargets()
}
