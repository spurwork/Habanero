// MARK: - Bundlable

/// An object which provides access to Habanero bundle.
public protocol Bundlable {}

// MARK: - Bundlable (Defaults)

extension Bundlable {
    static var bundle: Bundle? {
        let frameworkBundle = Bundle(for: Button.self)

        if let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("Habanero.bundle") {
            return Bundle(url: bundleURL)
        } else {
            return nil
        }
    }
}
