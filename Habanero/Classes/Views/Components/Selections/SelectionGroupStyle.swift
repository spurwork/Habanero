// MARK: - SelectionGroupStyle

/// Describes a `SelectionGroup` style based upon the number of selections that can be made.
public enum SelectionGroupStyle {
    /// A style for a `SelectionGroup` where only a single selection can be made (i.e. radio buttons).
    case single(SelectionGroupSingleStyle?)
    /// A style for a `SelectionGroup` where multiple selections can be made (i.e. checkboxes).
    case multi
}

// MARK: - SelectionGroupStyle: Equatable

extension SelectionGroupStyle: Equatable {
    public static func == (lhs: SelectionGroupStyle, rhs: SelectionGroupStyle) -> Bool {
        switch (lhs, rhs) {
        case (.multi, .multi): return true
        case (.single(.menu), .single(.menu)): return true
        case (.single(.allChoices), .single(.allChoices)): return true
        case (.single(.topChoices), .single(.topChoices)): return true
        default: return false
        }
    }
}

// MARK: - SelectionGroupSingleStyle

/// A style to apply to a `SelectionGroup` where only a single choice can be made at a time.
public enum SelectionGroupSingleStyle {
    /// The group is displayed as a condensed `Menu`.
    case menu
    /// Each choice within the group is displayed as an individual radio button.
    case allChoices
    /// The top choices within the group are displayed as radio buttons; additional choices
    /// are hidden under an expand button.
    case topChoices(Bool, String)
}
