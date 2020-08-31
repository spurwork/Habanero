// MARK: - SetRule: Rule

public struct SetRule: Rule {

    // MARK: Properties

    let checkContains: Bool
    let set: [String]

    // MARK: Initializer

    public init(in set: [String]) {
        self.set = set
        checkContains = true
    }

    public init(notIn set: [String]) {
        self.set = set
        checkContains = false
    }

    // MARK: Rule

    public func validate(_ value: String) -> Error? {
        if checkContains {
            return set.contains(value) ? nil : ValidatorError.elementNotInSet(set)
        } else {
            return (set.firstIndex(of: value) == nil) ? nil : ValidatorError.elementInSet(set)
        }
    }
}
