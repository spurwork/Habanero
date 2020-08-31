// MARK: - Selection

/// Describes a selection for a `SelectionGroup`.
public enum Selection {
    /// A single selection and its associated index. If index is `nil`, then nothing is selected.
    case single(Int?)
    /// A multiple selection and its associated indices. If the array is empty, then nothing is selected.
    case multi([Int])

    /// The currently selected index.
    public var selectedIndex: Int? {
        switch self {
        case .single(let index): return index
        case .multi: return nil
        }
    }

    /// The currently selected indices.
    public var selectedIndices: [Int] {
        switch self {
        case .single(let index):
            if let index = index {
                return [index]
            } else {
                return []
            }
        case .multi(let indices): return indices
        }
    }

    /// Is something currently selected?
    public var isSelected: Bool {
        switch self {
        case .single(let index): return index != nil
        case .multi(let indices): return !indices.isEmpty
        }
    }
}
