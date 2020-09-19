// MARK: - ColorsStandard: Colors, Bundlable

public struct ColorsStandard: Colors, Bundlable {

    // MARK: Action List

    public var tintActionListIcon: UIColor {
        return bundleColor(named: "TintActionListIcon", fallbackColor: .supportBlack100)
    }

    // MARK: Alert View

    public var backgroundAlert: UIColor {
        return bundleColor(named: "BackgroundAlert", fallbackColor: .surfaceBlack)
    }
    public var colorAlertError: UIColor {
        return bundleColor(named: "ColorAlertError", fallbackColor: .errorRed)
    }
    public var colorAlertInformation: UIColor {
        return bundleColor(named: "ColorAlertInformation", fallbackColor: .stateBlue)
    }
    public var colorAlertSuccess: UIColor {
        return bundleColor(named: "ColorAlertSuccess", fallbackColor: .stateGreen)
    }
    public var tintAlertCloseButton: UIColor {
        return bundleColor(named: "TintAlertCloseButton", fallbackColor: .white)
    }

    // MARK: Bar Button Item

    public var backgroundButtonBarBadge: UIColor {
        return bundleColor(named: "BackgroundButtonBarBadge", fallbackColor: .errorRed)
    }
    public var tintImageBarButtonItem: UIColor {
        return bundleColor(named: "TintImageBarButtonItem", fallbackColor: .surfaceBlack)
    }

    // MARK: Button

    public var tintButtonImagePrimary: UIColor {
        return bundleColor(named: "TintButtonImagePrimary", fallbackColor: .supportBlack100)
    }
    public var tintButtonImageDisabled: UIColor {
        return bundleColor(named: "TintButtonImageDisabled", fallbackColor: .supportGrey400)
    }

    // MARK: Borders

    public var borderDisabled: UIColor {
        return bundleColor(named: "BorderDisabled", fallbackColor: .supportGrey400)
    }

    // MARK: Calendar

    public var backgroundCalendar: UIColor {
        return bundleColor(named: "BackgroundCalendar", fallbackColor: .white)
    }
    public var backgroundCalendarDayHighlighted: UIColor {
        return bundleColor(named: "BackgroundCalendarDayHighlighted", fallbackColor: .supportGrey300)
    }
    public var backgroundCalendarDayNeedsAttention: UIColor {
        return bundleColor(named: "BackgroundCalendarDayNeedsAttention", fallbackColor: .errorRed)
    }
    public var backgroundCalendarDayNormal: UIColor {
        return bundleColor(named: "BackgroundCalendarDayNormal", fallbackColor: .surfaceBlack)
    }
    public var backgroundCalendarRangeBoundary: UIColor {
        return bundleColor(named: "BackgroundCalendarRangeBoundary", fallbackColor: .stateBlue)
    }
    public var backgroundCalendarRangeBoundaryStart: UIColor {
        return bundleColor(named: "BackgroundCalendarRangeBoundaryStart", fallbackColor: .secondaryBlue)
    }
    public var backgroundCalendarRangeBoundaryInactive: UIColor {
        return bundleColor(named: "BackgroundCalendarRangeBoundaryInactive", fallbackColor: .primaryBeige)
    }
    public var tintCalendarButton: UIColor {
        return bundleColor(named: "TintCalendarButton", fallbackColor: .surfaceBlack)
    }

    // MARK: Cells

    public var backgroundCell: UIColor {
        return bundleColor(named: "BackgroundCell", fallbackColor: .white)
    }
    public var backgroundCellPressed: UIColor {
        return bundleColor(named: "BackgroundCellPressed", fallbackColor: .supportGrey200)
    }

    // MARK: Contained Button

    public var backgroundButtonContainedDisabled: UIColor {
        return bundleColor(named: "BackgroundButtonContainedDisabled", fallbackColor: .supportGrey300)
    }
    public var backgroundButtonContainedPrimary: UIColor {
        return bundleColor(named: "BackgroundButtonContainedPrimary", fallbackColor: .surfaceBlack)
    }
    public var backgroundButtonContainedSecondary1: UIColor {
        return bundleColor(named: "BackgroundButtonContainedSecondary1", fallbackColor: .secondaryGreen)
    }
    public var backgroundButtonContainedSecondary2: UIColor {
        return bundleColor(named: "BackgroundButtonContainedSecondary2", fallbackColor: .secondaryPink)
    }
    public var backgroundButtonContainedSecondary3: UIColor {
        return bundleColor(named: "BackgroundButtonContainedSecondary3", fallbackColor: .secondaryOrange)
    }
    public var backgroundButtonContainedSecondary4: UIColor {
        return bundleColor(named: "BackgroundButtonContainedSecondary4", fallbackColor: .secondaryPurple)
    }
    public var backgroundButtonContainedSecondary5: UIColor {
        return bundleColor(named: "BackgroundButtonContainedSecondary5", fallbackColor: .secondaryBlue)
    }
    public var borderButtonContained: UIColor {
        return bundleColor(named: "BorderButtonContained", fallbackColor: .white)
    }
    public var textButtonContainedPrimary: UIColor {
        return bundleColor(named: "TextButtonContainedPrimary", fallbackColor: .white)
    }
    public var textButtonContainedSecondary: UIColor {
        return bundleColor(named: "TextButtonContainedSecondary", fallbackColor: .supportBlack300)
    }

    // MARK: Footer

    public var backgroundFooter: UIColor {
        return bundleColor(named: "BackgroundFooter", fallbackColor: .white)
    }
    public var textFooterLabelLink: UIColor {
        return bundleColor(named: "TextFooterLabelLink", fallbackColor: .stateBlue)
    }

    // MARK: General

    public var backgroundDivider: UIColor {
        return bundleColor(named: "BackgroundDivider", fallbackColor: .supportGrey200)
    }

    // MARK: Menu

    public var borderButtonMenu: UIColor {
        return bundleColor(named: "BorderButtonMenu", fallbackColor: .supportGrey300)
    }
    public var borderButtonMenuDisabled: UIColor {
        return bundleColor(named: "BorderButtonMenuDisabled", fallbackColor: UIColor.white.withAlphaComponent(0.6))
    }
    public var borderButtonMenuSelected: UIColor {
        return bundleColor(named: "BorderButtonMenuSelected", fallbackColor: .stateBlue)
    }
    public var textButtonMenuPlaceholder: UIColor {
        return bundleColor(named: "TextButtonMenuPlaceholder", fallbackColor: .supportGrey500)
    }
    public var textButtonMenuSelected: UIColor {
        return bundleColor(named: "TextButtonMenuSelected", fallbackColor: .supportBlack100)
    }

    // MARK: Menu Picker

    public var textMenuPickerRow: UIColor {
        return bundleColor(named: "TextMenuPickerRow", fallbackColor: .supportBlack300)
    }

    // MARK: Notes

    public var backgroundNotes: UIColor {
        return bundleColor(named: "BackgroundNotes", fallbackColor: .supportGrey200)
    }
    public var textNotesLink: UIColor {
        return bundleColor(named: "TextNotesLink", fallbackColor: .stateBlue)
    }

    // MARK: Outline Button

    public var borderButtonOutlinePrimary: UIColor {
        return bundleColor(named: "BorderButtonOutlinePrimary", fallbackColor: .surfaceBlack)
    }
    public var borderButtonOutlineSecondary0: UIColor {
        return bundleColor(named: "BorderButtonOutlineSecondary0", fallbackColor: .surfaceBlack)
    }
    public var borderButtonOutlineSecondary1: UIColor {
        return bundleColor(named: "BorderButtonOutlineSecondary1", fallbackColor: .surfaceBlack)
    }
    public var borderButtonOutlineSecondary2: UIColor {
        return bundleColor(named: "BorderButtonOutlineSecondary2", fallbackColor: .surfaceBlack)
    }
    public var borderButtonOutlineSecondary3: UIColor {
        return bundleColor(named: "BorderButtonOutlineSecondary3", fallbackColor: .surfaceBlack)
    }
    public var borderButtonOutlineSecondary4: UIColor {
        return bundleColor(named: "BorderButtonOutlineSecondary4", fallbackColor: .surfaceBlack)
    }
    public var borderButtonOutlineSecondary5: UIColor {
        return bundleColor(named: "BorderButtonOutlineSecondary5", fallbackColor: .surfaceBlack)
    }
    public var textButtonOutlinePrimary: UIColor {
        return bundleColor(named: "TextButtonOutlinePrimary", fallbackColor: .surfaceBlack)
    }
    public var textButtonOutlineSecondary: UIColor {
        return bundleColor(named: "TextButtonOutlineSecondary", fallbackColor: .surfaceBlack)
    }

    // MARK: Selection Button

    public var backgroundSelectionButtonCheckbox: UIColor {
        return bundleColor(named: "BackgroundSelectionButtonCheckbox", fallbackColor: .surfaceBlack)
    }
    public var tintSelectionButtonCheckbox: UIColor {
        return bundleColor(named: "TintSelectionButtonCheckbox", fallbackColor: .white)
    }
    public var tintSelectionButtonPressed: UIColor {
        return bundleColor(named: "TintSelectionButtonPressed", fallbackColor: .primaryBeige2)
    }
    public var tintSelectionButtonRadio: UIColor {
        return bundleColor(named: "TintSelectionButtonRadio", fallbackColor: .surfaceBlack)
    }

    // MARK: Status View

    public var colorStatusAlert: UIColor {
        return bundleColor(named: "ColorStatusAlert", fallbackColor: .errorRed)
    }
    public var colorStatusInactive: UIColor {
        return bundleColor(named: "ColorStatusInactive", fallbackColor: .supportGrey300)
    }
    public var colorStatusNormal: UIColor {
        return bundleColor(named: "ColorStatusNormal", fallbackColor: .surfaceBlack)
    }
    public var colorStatusSuccess: UIColor {
        return bundleColor(named: "ColorStatusSuccess", fallbackColor: .stateGreen)
    }
    public var colorStatusWarning: UIColor {
        return bundleColor(named: "ColorStatusWarning", fallbackColor: .stateYellow)
    }

    // MARK: Text

    public var textDisabled: UIColor {
        return bundleColor(named: "TextDisabled", fallbackColor: .textDisabled)
    }
    public var textMediumEmphasis: UIColor {
        return bundleColor(named: "TextMediumEmphasis", fallbackColor: .textMediumEmphasis)
    }
    public var textHighEmphasis: UIColor {
        return bundleColor(named: "TextHighEmphasis", fallbackColor: .textHighEmphasis)
    }
    public var textHighEmphasisInverted: UIColor {
        return bundleColor(named: "TextHighEmphasisInverted", fallbackColor: .white)
    }
    public var textError: UIColor {
        return bundleColor(named: "TextError", fallbackColor: .errorRed)
    }

    // MARK: Text Button

    public var textButtonTextPrimary: UIColor {
        return bundleColor(named: "TextButtonTextPrimary", fallbackColor: .primaryGold)
    }
    public var textButtonTextSecondary: UIColor {
        return bundleColor(named: "TextButtonTextSecondary", fallbackColor: .textHighEmphasis)
    }

    // MARK: Text Input

    public var colorTextInputNormal: UIColor {
        return bundleColor(named: "ColorTextInputNormal", fallbackColor: .supportGrey300)
    }
    public var colorTextInputError: UIColor {
        return bundleColor(named: "ColorTextInputError", fallbackColor: .errorRed)
    }
    public var colorTextInputSelected: UIColor {
        return bundleColor(named: "ColorTextInputSelected", fallbackColor: .stateBlue)
    }
    public var textInputPlaceholder: UIColor {
        return bundleColor(named: "TextInputPlaceholder", fallbackColor: .supportGrey400)
    }
    public var textInputTip: UIColor {
        return bundleColor(named: "TextInputTip", fallbackColor: .supportGrey400)
    }
    public var tintTextInputCursor: UIColor {
        return bundleColor(named: "TintTextInputCursor", fallbackColor: .textHighEmphasis)
    }
    public var tintTextInputIcon: UIColor {
        return bundleColor(named: "TintTextInputIcon", fallbackColor: .supportGrey400)
    }

    // MARK: Initializer

    public init() {}

    // MARK: Helpers

    func bundleColor(named: String, fallbackColor: UIColor) -> UIColor {
        return UIColor(named: named, in: ColorsStandard.bundle, compatibleWith: nil) ?? fallbackColor
    }
}
