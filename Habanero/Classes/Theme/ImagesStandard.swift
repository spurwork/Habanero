// MARK: - ImagesStandard: Images, Bundlable {

public struct ImagesStandard: Images, Bundlable {

    // MARK: Images

    public var add: UIImage? { return bundleImage(named: "Add") }
    public var bell: UIImage? { return bundleImage(named: "Bell") }
    public var briefcase: UIImage? { return bundleImage(named: "Briefcase") }
    public var camera: UIImage? { return bundleImage(named: "Camera") }
    public var caretDown: UIImage? { return bundleImage(named: "CaretDown") }
    public var caretLeft: UIImage? { return bundleImage(named: "CaretLeft") }
    public var caretLeftThick: UIImage? { return bundleImage(named: "CaretLeftThick") }
    public var caretRight: UIImage? { return bundleImage(named: "CaretRight") }
    public var caretRightThick: UIImage? { return bundleImage(named: "CaretRightThick") }
    public var caretUp: UIImage? { return bundleImage(named: "CaretUp") }
    public var checkCircle: UIImage? { return bundleImage(named: "CheckCircle") }
    public var checkSmall: UIImage? { return bundleImage(named: "CheckSmall") }
    public var clipboard: UIImage? { return bundleImage(named: "Clipboard") }
    public var close: UIImage? { return bundleImage(named: "Close") }
    public var closeCircle: UIImage? { return bundleImage(named: "CloseCircle") }
    public var closeCircleFill: UIImage? { return bundleImage(named: "CloseCircleFill") }
    public var edit: UIImage? { return bundleImage(named: "Edit") }
    public var email: UIImage? { return bundleImage(named: "Email") }
    public var empty: UIImage? { return bundleImage(named: "Empty") }
    public var error: UIImage? { return bundleImage(named: "Error") }
    public var faceSmile: UIImage? { return bundleImage(named: "FaceSmile") }
    public var folder: UIImage? { return bundleImage(named: "Folder") }
    public var gear: UIImage? { return bundleImage(named: "Gear") }
    public var heartPlus: UIImage? { return bundleImage(named: "HeartPlus") }
    public var help: UIImage? { return bundleImage(named: "Help") }
    public var info: UIImage? { return bundleImage(named: "Info") }
    public var lightBulb: UIImage? { return bundleImage(named: "LightBulb") }
    public var lock: UIImage? { return bundleImage(named: "Lock") }
    public var logout: UIImage? { return bundleImage(named: "Logout") }
    public var menu: UIImage? { return bundleImage(named: "Menu") }
    public var money: UIImage? { return bundleImage(named: "Money") }
    public var notes: UIImage? { return bundleImage(named: "Notes") }
    public var parking: UIImage? { return bundleImage(named: "Parking") }
    public var phoneCall: UIImage? { return bundleImage(named: "PhoneCall") }
    public var profile: UIImage? { return bundleImage(named: "Profile") }
    public var search: UIImage? { return bundleImage(named: "Search") }
    public var ticket: UIImage? { return bundleImage(named: "Ticket") }
    public var timeClock: UIImage? { return bundleImage(named: "TimeClock") }
    public var uniform: UIImage? { return bundleImage(named: "Uniform") }
    public var user: UIImage? { return bundleImage(named: "User") }
    public var warning: UIImage? { return bundleImage(named: "Warning") }

    // MARK: Initializer

    public init() {}

    // MARK: Helpers

    func bundleImage(named: String) -> UIImage? {
        return UIImage(named: named, in: ImagesStandard.bundle, compatibleWith: nil)
    }
}
