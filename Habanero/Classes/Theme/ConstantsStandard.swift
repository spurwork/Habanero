// MARK: - ConstantsStandard: Constants

public struct ConstantsStandard: Constants {

    // swiftlint:disable line_length

    // MARK: Action List Cell

    public var actionListAccessoryImageSize: CGSize { return CGSize(width: 14, height: 44.0) }
    public var actionListAccessoryDetailAndImageWidth: CGFloat { return 110 }
    public var actionListAccessoryStatusAndDetailWidth: CGFloat { return 195 }
    public var actionListAccessoryViewSpacing: CGFloat { return 16 }
    public var actionListAccessoryDetailMinimumWidth: CGFloat { return 45 }

    // MARK: Alert View

    public var alertViewCloseButtonWidth: CGFloat { return 16 }
    public var alertViewContainingViewWidthFactor: CGFloat { return 0.92 }
    public var alertViewContentSpacing: CGFloat { return 12 }
    public var alertViewCornerRadius: CGFloat { return 8 }
    public var alertViewFadeDuration: CGFloat { return 0.2 }
    public var alertViewIconWidth: CGFloat { return 20 }
    public var alertViewInsets: UIEdgeInsets { return UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12) }
    public var alertViewShowDuration: Double { return 2.0 }

    // MARK: Bar Button Item

    public var barButtonItemBadgeCircleSize: CGSize { return CGSize(width: 9, height: 7) }
    public var barButtonItemBadgeFontSize: CGFloat { return 11 }
    public var barButtonItemBadgeLabelSize: CGSize { return CGSize(width: 16.0, height: 16.0) }
    public var barButtonItemBadgeOffset: CGPoint { return CGPoint(x: 4, y: 6) }
    public var barButtonItemBadgeOffsetFallback: CGPoint { return CGPoint(x: -11, y: -4) }
    public var barButtonItemBadgeWidth: CGFloat { return minimumTouchSize.width }
    public var barButtonItemImageEdgeInsets: UIEdgeInsets { return UIEdgeInsets(uniform: 12) }
    public var barButtonItemImageSize: CGSize { return CGSize(width: minimumTouchSize.width, height: minimumTouchSize.height) }

    // MARK: Button

    public var buttonBorderWidth: CGFloat { return 1 }
    public var buttonContentEdgeInsets: UIEdgeInsets { return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) }
    public var buttonCornerRadiusSmall: CGFloat { return 4 }
    public var buttonCornerRadiusStandard: CGFloat { return 8 }
    public var buttonHeight: CGFloat { return 44 }
    public var buttonTextMinimumScaleFactor: CGFloat { return 0.75 }

    // MARK: Calendar

    public var calendarDayViewInsets: UIEdgeInsets { return UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0) }
    public var calendarDayViewInsetsWithMultiStatus: UIEdgeInsets { return UIEdgeInsets(top: 5, left: 0, bottom: 3, right: 0) }
    public var calendarDayViewInsetsWithStatus: UIEdgeInsets { return UIEdgeInsets(top: 3, left: 0, bottom: 6, right: 0) }
    public var calendarViewButtonImageInsets: UIEdgeInsets { return UIEdgeInsets(horizontal: 15) }
    public var calendarViewDaySpacing: CGFloat { return 8 }
    public var calendarViewDotDimension: CGFloat { return 6 }
    public var calendarViewDirectionalLayoutMargins: NSDirectionalEdgeInsets { return NSDirectionalEdgeInsets(horizontal: 8) }
    public var calendarViewInterMonthSpacing: CGFloat { return 24 }
    public var calendarViewMinimumButtonDimension: CGFloat { return 44 }

    // MARK: Checkbox

    public var checkboxCornerRadius: CGFloat { return 5 }
    public var checkboxLayoutMargins: UIEdgeInsets { return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0) }
    public var checkboxPressedCircleInset: CGFloat { return 4 }
    public var checkboxSideLength: CGFloat { return 28 }

    // MARK: Contained Button

    public var buttonContainedInnerBorderInset: CGFloat { return 1 }

    // MARK: DetailTextField

    public var detailTextFieldHeight: CGFloat { return 24 }
    public var detailTextFieldUnderlineHeight: CGFloat { return 1 }

    // MARK: DetailTextView

    public var detailTextViewBorderWidth: CGFloat { return 1 }
    public var detailTextViewCornerRadius: CGFloat { return 8 }
    public var detailTextViewCountInset: CGFloat { return 4 }
    public var detailTextViewHeight: CGFloat { return 100 }

    public func detailTextViewInsets(showCharacterCount: Bool) -> UIEdgeInsets {
        let rightPadding: CGFloat = showCharacterCount ? (8 * 8) : 8
        return UIEdgeInsets(top: 12, left: 8, bottom: 8, right: rightPadding + textInputSystemClearIconSideLength + 8)
    }

    // MARK: Footer

    public var footerButtonSpacing: CGFloat { return 16 }
    public var footerContentInsets: UIEdgeInsets { return UIEdgeInsets(uniform: 16) }
    public var footerContentSpacing: CGFloat { return 18 }

    // MARK: General

    public var alphaDisabled: CGFloat { return 0.6 }
    public var anchorBottomExtraVerticalPadding: CGFloat { return 76 }
    public var anchorTopExtraVerticalPadding: CGFloat { return 16 }
    public var minimumTouchSize: CGSize { return CGSize(width: 44.0, height: 44.0) }

    // MARK: Menu

    public var menuButtonTitleEdgeInsets: UIEdgeInsets { return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) }
    public var menuBaseInsetDimension: CGFloat { return 8 }

    // MARK: Menu Picker

    public var menuPickerRowHeight: CGFloat { return 44 }
    public var menuPickerTextMinimumScaleFactor: CGFloat { return 0.75 }

    // MARK: Notes

    public var notesViewCornerRadius: CGFloat { return 8 }

    // MARK: Radio Button

    public var radioButtonDiameter: CGFloat { return 29 }

    // MARK: Selection Control

    public var selectionControlButtonToTitleSpacing: CGFloat { return 18 }
    public var selectionControlTextSpacing: CGFloat { return 6 }

    // MARK: Selection Group

    public var selectionGroupTopChoicesMax: UInt { return 20 }
    public var selectionGroupTopChoicesMin: UInt { return 10 }
    public var selectionGroupMenuChoiceThreshold: UInt { return 7 }
    public var selectionGroupChoiceSpacing: CGFloat { return 16 }

    // MARK: Selection Group (Expand Button)

    public var expandButtonCaretImageInsets: UIEdgeInsets { return UIEdgeInsets(uniform: 10) }
    public var expandButtonTitleCaretSpacing: CGFloat { return 10 }

    // MARK: Status View

    public var statusViewDotWidth: CGFloat { return 8 }

    // MARK: Text Input

    public var textInputCharacterCountLabelWidth: CGFloat { return 50 }
    public var textInputContentInsets: UIEdgeInsets { return UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0) }
    public var textInputContentVerticalSpacing: CGFloat { return 8 }
    public var textInputFontStyle: FontStyle { return .labelLarge }
    public var textInputIconFrameSideLength: CGFloat { return textInputSystemClearIconSideLength * 2 }
    public var textInputIconInsets: UIEdgeInsets { return UIEdgeInsets(uniform: textInputSystemClearIconSideLength / 2) }
    public var textInputMaxCharacters: UInt { return 100 }
    public var textInputMaxCharactersMultiline: UInt { return 250 }
    public var textInputStackInsets: UIEdgeInsets { return UIEdgeInsets(top: 8, left: 16, bottom: 20, right: 16) }
    public var textInputSystemClearIconSideLength: CGFloat { return 14 }

    // swiftlint:enable line_length

    // MARK: Initializer

    public init() {}
}
