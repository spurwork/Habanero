// MARK: - Colors

/// An object that defines all the colors for Habanero.
public protocol Colors {

    // MARK: Action List

    /// Tint color for action list icons.
    var tintActionListIcon: UIColor { get }

    // MARK: Alert View

    /// Background color for `AlertView`.
    var backgroundAlert: UIColor { get }
    /// Alert View - Error color.
    var colorAlertError: UIColor { get }
    /// Alert View - Information color.
    var colorAlertInformation: UIColor { get }
    /// Alert View - Success color.
    var colorAlertSuccess: UIColor { get }
    /// Tint color for close button in an `AlertView`.
    var tintAlertCloseButton: UIColor { get }

    // MARK: Bar Button Item

    /// Background color for `UIBarButtonItem` badges.
    var backgroundButtonBarBadge: UIColor { get }
    /// Tint color for the image in a `UIBarButtonItem`.
    var tintImageBarButtonItem: UIColor { get }

    // MARK: Button

    /// Primary tint color for an image in a `UIButton`.
    var tintButtonImagePrimary: UIColor { get }
    /// Disabled tint color for an image in a `UIButton`.
    var tintButtonImageDisabled: UIColor { get }

    // MARK: Borders

    /// Standard border color.
    var borderDisabled: UIColor { get }

    // MARK: Calendar

    /// Background color for a calendar day that needs attention.
    var backgroundCalendarDayNeedsAttention: UIColor { get }
    /// Background color for a calendar day that has normal status.
    var backgroundCalendarDayNormal: UIColor { get }
    /// Background color for a range boundary in a `CalendarView`.
    var backgroundCalendarRangeBoundary: UIColor { get }
    /// Background color for a starting range boundary in a `CalendarView`.
    var backgroundCalendarRangeBoundaryStart: UIColor { get }
    /// Background color for an inactive range boundary in a `CalendarView`.
    var backgroundCalendarRangeBoundaryInactive: UIColor { get }
    /// Tint color for buttons in a `CalendarView`.
    var tintCalendarButton: UIColor { get }

    // MARK: Cells

    /// Background color for table cells.
    var backgroundCell: UIColor { get }
    /// Background color when table cell is pressed.
    var backgroundCellPressed: UIColor { get }

    // MARK: Contained Button

    /// Contained Button - Disabled background color.
    var backgroundButtonContainedDisabled: UIColor { get }
    /// Contained Button - Primary background color.
    var backgroundButtonContainedPrimary: UIColor { get }
    /// Contained Button - Secondary 1 background color.
    var backgroundButtonContainedSecondary1: UIColor { get }
    /// Contained Button - Secondary 2 background color.
    var backgroundButtonContainedSecondary2: UIColor { get }
    /// Contained Button - Secondary 3 background color.
    var backgroundButtonContainedSecondary3: UIColor { get }
    /// Contained Button - Secondary 4 background color.
    var backgroundButtonContainedSecondary4: UIColor { get }
    /// Contained Button - Secondary 5 background color.
    var backgroundButtonContainedSecondary5: UIColor { get }
    /// Contained Button - Border color.
    var borderButtonContained: UIColor { get }
    /// Contained Button - Primary text color.
    var textButtonContainedPrimary: UIColor { get }
    /// Contained Button - Secondary text color.
    var textButtonContainedSecondary: UIColor { get }

    // MARK: Footer

    /// Background color for `Footer`.
    var backgroundFooter: UIColor { get }
    /// Text color for `Footer` label when it is a tappable link.
    var textFooterLabelLink: UIColor { get }

    // MARK: General

    /// Background color for divider lines.
    var backgroundDivider: UIColor { get }

    // MARK: Menu

    /// Border color used for the button contained within a `Menu`.
    var borderButtonMenu: UIColor { get }
    /// Border color used for the button contained within a `Menu` when it is disabled.
    var borderButtonMenuDisabled: UIColor { get }
    /// Border color used for the button contained within a `Menu` when it is selected.
    var borderButtonMenuSelected: UIColor { get }
    /// Text color for the button contained within a `Menu` when a placeholder value is used.
    var textButtonMenuPlaceholder: UIColor { get }
    /// Text color for the button contained within a `Menu` when a value has been selected.
    var textButtonMenuSelected: UIColor { get }

    // MARK: Menu Picker

    /// Text color for `MenuPicker` rows.
    var textMenuPickerRow: UIColor { get }

    // MARK: Notes

    /// Background color for `NotesView`.
    var backgroundNotes: UIColor { get }

    // MARK: Outline Button

    /// Outline Button - Primary border color.
    var borderButtonOutlinePrimary: UIColor { get }
    /// Outline Button - Secondary 0 border color.
    var borderButtonOutlineSecondary0: UIColor { get }
    /// Outline Button - Secondary 1 border color.
    var borderButtonOutlineSecondary1: UIColor { get }
    /// Outline Button - Secondary 2 border color.
    var borderButtonOutlineSecondary2: UIColor { get }
    /// Outline Button - Secondary 3 border color.
    var borderButtonOutlineSecondary3: UIColor { get }
    /// Outline Button - Secondary 4 border color.
    var borderButtonOutlineSecondary4: UIColor { get }
    /// Outline Button - Secondary 5 border color.
    var borderButtonOutlineSecondary5: UIColor { get }
    /// Outline Button - Primary text color.
    var textButtonOutlinePrimary: UIColor { get }
    /// Outline Button - Secondary text color.
    var textButtonOutlineSecondary: UIColor { get }

    // MARK: Selection Button

    /// Background color for checkboxes.
    var backgroundSelectionButtonCheckbox: UIColor { get }
    /// Tint color for checkboxes.
    var tintSelectionButtonCheckbox: UIColor { get }
    /// Tint color for when a selection button is pressed.
    var tintSelectionButtonPressed: UIColor { get }
    /// Tint color for radio buttons.
    var tintSelectionButtonRadio: UIColor { get }

    // MARK: Status View

    /// Status View - Alert color.
    var colorStatusAlert: UIColor { get }
    /// Status View - Inactive color.
    var colorStatusInactive: UIColor { get }
    /// Status View - Normal color.
    var colorStatusNormal: UIColor { get }
    /// Status View - Success color.
    var colorStatusSuccess: UIColor { get }
    /// Status View - Warning color.
    var colorStatusWarning: UIColor { get }

    // MARK: Text

    /// Disabled text color.
    var textDisabled: UIColor { get }
    /// Medium emphasis text color.
    var textMediumEmphasis: UIColor { get }
    /// High emphasis text color.
    var textHighEmphasis: UIColor { get }
    /// Inverted high emphasis text color.
    var textHighEmphasisInverted: UIColor { get }
    /// Error text color.
    var textError: UIColor { get }

    // MARK: Text Button

    /// Text Button - Primary text color.
    var textButtonTextPrimary: UIColor { get }
    /// Text Button - Secondary text color.
    var textButtonTextSecondary: UIColor { get }

    // MARK: Text Input

    /// Color for `TextInput` underline or border.
    var colorTextInputNormal: UIColor { get }
    /// Color for `TextInput` underline or border when `TextInput` has an error.
    var colorTextInputError: UIColor { get }
    /// Color for `TextInput` underline or border when `TextInput` is selected.
    var colorTextInputSelected: UIColor { get }
    /// Text color for `TextInput` placeholder.
    var textInputPlaceholder: UIColor { get }
    /// Text color for `TextInput` tip.
    var textInputTip: UIColor { get }
    /// Tint color for `TextInput` cursor.
    var tintTextInputCursor: UIColor { get }
    /// Tint color for `TextInput` icons.
    var tintTextInputIcon: UIColor { get }
}
