// MARK: - NoEmojiRule: Rule

public struct NoEmojiRule: Rule {

    // MARK: Initializer

    public init() {}

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        return value.containsEmoji ? ValidatorError.containsEmoji : nil
    }
}
