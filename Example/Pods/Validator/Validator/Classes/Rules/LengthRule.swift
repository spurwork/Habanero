// MARK: - LengthRule: Rule

public struct LengthRule: Rule {

    // MARK: Properties

    let length: Int

    let lessThan: Bool?
    let inclusive: Bool

    public var maxLength: UInt? {
        if let lessThan = lessThan, lessThan {
            return inclusive ? UInt(length) : UInt(length - 1)
        } else {
            return nil
        }
    }

    // MARK: Initializer

    public init(lessThan length: Int) {
        self.length = length
        inclusive = false
        lessThan = true
    }

    public init(lessThanOrEqualTo length: Int) {
        self.length = length
        inclusive = true
        lessThan = true
    }

    public init(greaterThan length: Int) {
        self.length = length
        inclusive = false
        lessThan = false
    }

    public init(greaterThanOrEqualTo length: Int) {
        self.length = length
        inclusive = true
        lessThan = false
    }

    public init(equalTo length: Int) {
        self.length = length
        inclusive = true
        lessThan = nil
    }

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        if let lessThan = lessThan {
            if lessThan && inclusive {
                return value.count <= length ? nil : ValidatorError.lengthGreaterThan(length)
            } else if lessThan && !inclusive {
                return value.count < length ? nil : ValidatorError.lengthGreaterThan(length - 1)
            } else if !lessThan && inclusive {
                return value.count >= length ? nil : ValidatorError.lengthLessThan(length)
            } else {
                return value.count > length ? nil : ValidatorError.lengthLessThan(length + 1)
            }
        } else {
            return value.count == length ? nil : ValidatorError.lengthNotEqualTo(length)
        }
    }
}
