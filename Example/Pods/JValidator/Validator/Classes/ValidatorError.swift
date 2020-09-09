// MARK: - ValidatorError: Error

public enum ValidatorError: Error {
    case containsEmoji
    case dateInvalid
    case dateNotOlderThan(Date, String)
    case dateNotOlderThanOrEqualTo(Date, String)
    case dateNotYoungerThan(Date, String)
    case dateNotYoungerThanOrEqualTo(Date, String)
    case doesntMatchRegex(String)
    case elementInCharacterSet(CharacterSet)
    case elementInSet([String])
    case elementNotInCharacterSet(CharacterSet)
    case elementNotInSet([String])
    case empty
    case lengthGreaterThan(Int)
    case lengthLessThan(Int)
    case lengthNotEqualTo(Int)
    case notFloat
}

// MARK: - ValidatorError: LocalizedError

extension ValidatorError: LocalizedError {
    public var errorDescription: String? { return "ValidatorError: \(self)" }
    public var failureReason: String? { return nil }
    public var recoverySuggestion: String? { return nil }
    public var helpAnchor: String? { return nil }
}

// MARK: - ValidatorError: CustomNSError

extension ValidatorError: CustomNSError {
    static public var errorDomain: String {
        return "com.jarrodparkes.validator"
    }

    public var errorCode: Int {
        switch self {
        case .containsEmoji: return 1
        case .dateInvalid: return 2
        case .dateNotOlderThan: return 3
        case .dateNotOlderThanOrEqualTo: return 4
        case .dateNotYoungerThan: return 5
        case .dateNotYoungerThanOrEqualTo: return 6
        case .doesntMatchRegex: return 7
        case .elementInCharacterSet: return 8
        case .elementInSet: return 9
        case .elementNotInCharacterSet: return 10
        case .elementNotInSet: return 10
        case .empty: return 11
        case .lengthGreaterThan: return 12
        case .lengthLessThan: return 13
        case .lengthNotEqualTo: return 14
        case .notFloat: return 15
        }
    }

    public var errorUserInfo: [String: Any] {
        return [:]
    }
}
