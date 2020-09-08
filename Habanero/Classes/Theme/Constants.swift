// MARK: - Constants

/// An object that defines all the constants for Habanero.
public protocol Constants {

    // MARK: Action List Cell

    /// The size of an accessory image in an `ActionListCell`.
    var actionListAccessoryImageSize: CGSize { get }

    /// The width of an `ActionListCell` accessory view containing a detail label and image.
    var actionListAccessoryDetailAndImageWidth: CGFloat { get }

    /// The width of an `ActionListCell` accessory view containing a status view and detail label.
    var actionListAccessoryStatusAndDetailWidth: CGFloat { get }

    /// The spacing between accessory views in an `ActionListCell`.
    var actionListAccessoryViewSpacing: CGFloat { get }

    /// The minimum width of a detail label in an `ActionListCell`.
    var actionListAccessoryDetailMinimumWidth: CGFloat { get }

    // MARK: Alert View

    /// The width of the close button in an `AlertView`.
    var alertViewCloseButtonWidth: CGFloat { get }

    /// The percentage (0.0-1.0) of the containing view's width to use for an `AlertView`.
    var alertViewContainingViewWidthFactor: CGFloat { get }

    /// The spacing between content in an `AlertView`.
    var alertViewContentSpacing: CGFloat { get }

    /// The amount of rounding to apply to the corners of an `AlertView`.
    var alertViewCornerRadius: CGFloat { get }

    /// The amount of time it takes for an `AlertView` to fade-in or fade-out.
    var alertViewFadeDuration: CGFloat { get }

    /// The width of the icon in an `AlertView`.
    var alertViewIconWidth: CGFloat { get }

    /// The insets for an `AlertView`.
    var alertViewInsets: UIEdgeInsets { get }

    /// The amount of time an `AlertView` is shown.
    var alertViewShowDuration: Double { get }

    // MARK: Bar Button Item

    /// The size of the badge circle for a `UIBarButtonItem`.
    var barButtonItemBadgeCircleSize: CGSize { get }

    /// The badge font size to use for a `UIBarButtonItem`.
    var barButtonItemBadgeFontSize: CGFloat { get }

    /// The size of the badge label used with `UIBarButtonItem`.
    var barButtonItemBadgeLabelSize: CGSize { get }

    /// The standard badge offset for a `UIBarButtonItem`.
    var barButtonItemBadgeOffset: CGPoint { get }

    /// The standard badge offset for a `UIBarButtonItem` for older versions of iOS.
    var barButtonItemBadgeOffsetFallback: CGPoint { get }

    /// The width for a badge on a `UIBarButtonItem`.
    var barButtonItemBadgeWidth: CGFloat { get }

    /// The image edge insets for a `UIBarButtonItem`.
    var barButtonItemImageEdgeInsets: UIEdgeInsets { get }

    /// The size of an image in a `UIBarButtonItem`.
    var barButtonItemImageSize: CGSize { get }

    // MARK: Button

    /// The border width for a `Button`.
    var buttonBorderWidth: CGFloat { get }

    /// The standard content edge insets for a `Button`.
    var buttonContentEdgeInsets: UIEdgeInsets { get }

    /// A smaller amount of rounding to apply to the corners of certain `Button` styles like those used for menus.
    var buttonCornerRadiusSmall: CGFloat { get }

    /// The standard amount of rounding to apply to the corners of a `Button`.
    var buttonCornerRadiusStandard: CGFloat { get }

    /// The height of a `Button`.
    var buttonHeight: CGFloat { get }

    /// The minimum scaling factor for the text label inside of a `Button`.
    var buttonTextMinimumScaleFactor: CGFloat { get }

    // MARK: Calendar

    /// The insets to apply to a `CalendarDayView`.
    var calendarDayViewInsets: UIEdgeInsets { get }

    /// The insets to apply to a `CalendarDayView` displaying a multiple status count.
    var calendarDayViewInsetsWithMultiStatus: UIEdgeInsets { get }

    /// The insets to apply to a `CalendarDayView` with a status.
    var calendarDayViewInsetsWithStatus: UIEdgeInsets { get }

    /// The image insets to apply to buttons in a `CalendarView`.
    var calendarViewButtonImageInsets: UIEdgeInsets { get }

    /// The amount of horizontal and vertical spacing between each `CalendarDayView`.
    var calendarViewDaySpacing: CGFloat { get }

    /// The dimension to use for a `CalendarView` dot's width and height.
    var calendarViewDotDimension: CGFloat { get }

    /// The insets to apply to the directional layout of a `CalendarView`.
    var calendarViewDirectionalLayoutMargins: NSDirectionalEdgeInsets { get }

    /// The amount of spacing between each month in a `CalendarView`.
    var calendarViewInterMonthSpacing: CGFloat { get }

    /// The minimum dimension to use for a `CalendarView` button.
    var calendarViewMinimumButtonDimension: CGFloat { get }

    // MARK: Checkbox

    /// The amount of rounding to apply to the corners of a `CheckboxButton`.
    var checkboxCornerRadius: CGFloat { get }

    /// The layout margins for a checkbox used within a `SelectionControl`.
    var checkboxLayoutMargins: UIEdgeInsets { get }

    /// The inset that determines the size of the circle which appears when a `CheckboxButton` is pressed.
    var checkboxPressedCircleInset: CGFloat { get }

    /// The length of the side of a `CheckboxButton`.
    var checkboxSideLength: CGFloat { get }

    // MARK: Contained Button

    /// The inset for the inner-border for a `Button` styled with `ButtonStyleContained`.
    var buttonContainedInnerBorderInset: CGFloat { get }

    // MARK: DetailTextField

    /// The height of the `UITextField` inside of a `DetailTextField`.
    var detailTextFieldHeight: CGFloat { get }

    /// The height of a `DetailTextField` underline.
    var detailTextFieldUnderlineHeight: CGFloat { get }

    // MARK: DetailTextView

    /// The border width of the `UITextView` inside of a `DetailTextView`.
    var detailTextViewBorderWidth: CGFloat { get }

    /// The corner radius of the `UITextView` inside of a `DetailTextView`.
    var detailTextViewCornerRadius: CGFloat { get }

    /// The inset for character count and icon in the `UITextView` inside of a `DetailTextView`.
    var detailTextViewCountInset: CGFloat { get }

    /// The height of the `UITextView` inside of a `DetailTextView`.
    var detailTextViewHeight: CGFloat { get }

    /// Returns the content insets to use for the `UITextView` inside of a `DetailTextView`.
    /// - Parameter showCharacterCount: Is the character count being shown alongside the text?
    func detailTextViewInsets(showCharacterCount: Bool) -> UIEdgeInsets

    // MARK: Footer

    /// The amount of spacing between buttons in a `Footer`.
    var footerButtonSpacing: CGFloat { get }

    /// The content insets for a `Footer`.
    var footerContentInsets: UIEdgeInsets { get }

    /// The amount of spacing between any content and buttons in a `Footer`.
    var footerContentSpacing: CGFloat { get }

    // MARK: General

    /// The alpha value to use when a control is disabled.
    var alphaDisabled: CGFloat { get }

    /// The amount of additional vertical padding to apply to a bottom anchor.
    var anchorBottomExtraVerticalPadding: CGFloat { get }

    /// The amount of additional vertical padding to apply to a top anchor.
    var anchorTopExtraVerticalPadding: CGFloat { get }

    /// The minimum touch size according to Apple's Human Interface Guidelines.
    var minimumTouchSize: CGSize { get }

    // MARK: Menu

    /// The title inset for the button contained within a `Menu`.
    var menuButtonTitleEdgeInsets: UIEdgeInsets { get }

    /// The base inset dimension to use when displaying a `Menu`.
    var menuBaseInsetDimension: CGFloat { get }

    // MARK: Menu Picker

    /// The height of (selection) rows for a `MenuPicker`.
    var menuPickerRowHeight: CGFloat { get }

    /// The minimum scaling factor for the text labels inside of a `MenuPicker`.
    var menuPickerTextMinimumScaleFactor: CGFloat { get }

    // MARK: Notes

    /// The insets to use for content within a `NotesView`.
    var notesContentInsets: UIEdgeInsets { get }

    /// The spacing to use between content within a `NotesView`.
    var notesContentSpacing: CGFloat { get }

    /// The amount of rounding to apply to the corners of a `NotesView`.
    var notesViewCornerRadius: CGFloat { get }

    // MARK: Radio Button

    /// The diameter for a `RadioButton`.
    var radioButtonDiameter: CGFloat { get }

    // MARK: Selection Control

    /// The spacing between a `SelectionControl` button and title.
    var selectionControlButtonToTitleSpacing: CGFloat { get }

    /// The spacing between `SelectionControl` title and tip.
    var selectionControlTextSpacing: CGFloat { get }

    // MARK: Selection Group

    /// The maximum number of choices that can be provided for the `SelectionGroupSingleStyle.topChoices` style.
    var selectionGroupTopChoicesMax: UInt { get }

    /// The mininum number of choices that must be provided for the `SelectionGroupSingleStyle.topChoices` style.
    var selectionGroupTopChoicesMin: UInt { get }

    /// For an unspecified `SelectionGroupSingleStyle`, the number of choices that must be exceeded
    /// for a `Menu` to be used versus a list of radio buttons.
    var selectionGroupMenuChoiceThreshold: UInt { get }

    /// The spacing between choices in a `SelectionGroup`.
    var selectionGroupChoiceSpacing: CGFloat { get }

    // MARK: Selection Group (Expand Button)

    /// The insets to apply to the expand button caret image.
    var expandButtonCaretImageInsets: UIEdgeInsets { get }

    /// The spacing between the title and caret in the expand button.
    var expandButtonTitleCaretSpacing: CGFloat { get }

    // MARK: Status View

    /// The width of the dot in a `StatusView`.
    var statusViewDotWidth: CGFloat { get }

    // MARK: Text Input

    /// The width of the character count label contained within a `TextInput.`
    var textInputCharacterCountLabelWidth: CGFloat { get }

    /// The content insets for a `TextInput`.
    var textInputContentInsets: UIEdgeInsets { get }

    /// The vertical spacing between views in a `TextInput`.
    var textInputContentVerticalSpacing: CGFloat { get }

    /// The `FontStyle` to use for a `TextInput` control and its character count.
    var textInputFontStyle: FontStyle { get }

    /// The width and length for the icon frame in a `TextInput`.
    var textInputIconFrameSideLength: CGFloat { get }

    /// The insets for the icon contained within a `TextInput`.
    var textInputIconInsets: UIEdgeInsets { get }

    /// The stack insets for a `TextInput`.
    var textInputStackInsets: UIEdgeInsets { get }

    /// The maximum amount of characters allowed for a `TextInput` when multiline is false.
    var textInputMaxCharacters: UInt { get }

    /// The maximum amount of characters allowed for a `TextInput` when multiline is true.
    var textInputMaxCharactersMultiline: UInt { get }

    /// The standard width and length for the system clear button in a `UITextView`.
    var textInputSystemClearIconSideLength: CGFloat { get }
}
