// MARK: - TextInputError: Error

public enum TextInputError: Error {
    case cannotExceedCharacterCount(UInt)
    case deletingWhileEmpty
}

// MARK: - TextInputError: LocalizedError

extension TextInputError: LocalizedError {
    public var errorDescription: String? { return "TextInputError: \(self)" }
    public var failureReason: String? { return nil }
    public var recoverySuggestion: String? { return nil }
    public var helpAnchor: String? { return nil }
}

// MARK: - TextInputError: CustomNSError

extension TextInputError: CustomNSError {
    static public var errorDomain: String {
        return "com.jarrodparkes.habanero.textinput"
    }

    public var errorCode: Int {
        switch self {
        case .cannotExceedCharacterCount: return 1
        case .deletingWhileEmpty: return 2
        }
    }

    public var errorUserInfo: [String: Any] {
        return [:]
    }
}
