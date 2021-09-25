// MARK: - MenuPickerDisplayable

/// An object that can be displayed by a `MenuPicker`.
public protocol MenuPickerDisplayable {
    /// The title placed above the picker when the picker is shown.
    var pickerTitle: String { get }

    /// The title for the button below the picker which accepts a selection.
    var pickerActionTitle: String { get }

    /// The title for the button which dismisses the picker.
    var pickerDismissTitle: String { get }

    /// The number of sections in the picker.
    var numberOfComponents: Int { get }

    /// Returns the number of rows in a component.
    /// - Parameter component: A zero-indexed number identifying a component. Components are numbered left-to-right.
    func numberOfRows(inComponent component: Int) -> Int

    /// Returns the index for the row that should be selected in a component when the picker appears.
    /// - Parameter component: A zero-indexed number identifying a component. Components are numbered left-to-right.
    func defaultSelectedRow(forComponent component: Int) -> Int

    /// Returns the proportion of the picker's total width that should be used for a component.
    /// The value returned should range between 0 and 1. If there are multiple components, the sum of all width factors
    /// should be 1.
    /// - Parameter component: A zero-indexed number identifying a component. Components are numbered left-to-right.
    func widthFactor(forComponent component: Int) -> CGFloat

    /// Returns the title to use for a row within a component.
    /// - Parameters:
    ///   - row: A zero-indexed number identifying a row. Rows are numbered top-to-bottom.
    ///   - component: A zero-indexed number identifying a component. Components are numbered left-to-right.
    func title(forRow row: Int, component: Int) -> String

    /// Returns the text alignment to use for a row's title within a component.
    /// - Parameters:
    ///   - row: A zero-indexed number identifying a row. Rows are numbered top-to-bottom.
    ///   - component: A zero-indexed number identifying a component. Components are numbered left-to-right.
    func titleAlignment(forRow row: Int, component: Int) -> NSTextAlignment
}

// MARK: - MenuPickerDelegate

public protocol MenuPickerDelegate: AnyObject {
    func menuPickerFinished(pickerView: UIPickerView, selectedIndices: [Int])
}

// MARK: - MenuPicker: NSObject {

/// A design element that allows a user to selected a value from a set of possible values.
/// This element is displayed by a `Menu` when the user is attempting to set a new value.
/// Under the hood, a standard `UIPickerView` is used to present values and allow the user to
/// select a value.
public class MenuPicker: NSObject {

    // MARK: Properties

    public static let shared = MenuPicker()

    private var theme: Theme?
    private var displayable: MenuPickerDisplayable?

    // MARK: Helpers

    public func show(theme: Theme,
                     displayable: MenuPickerDisplayable,
                     delegate: MenuPickerDelegate,
                     presentingVC: UIViewController,
                     tag: Int,
                     menu: Menu? = nil) {
        self.theme = theme
        self.displayable = displayable

        let alertController = UIAlertController(title: displayable.pickerTitle,
                                                message: nil,
                                                preferredStyle: .actionSheet)

        // create picker
        let pickerView = UIPickerView(frame: .zero)
        pickerView.tag = tag
        pickerView.dataSource = self
        pickerView.delegate = self
        for index in 0..<pickerView.numberOfComponents {
            pickerView.selectRow(displayable.defaultSelectedRow(forComponent: index),
                                 inComponent: index,
                                 animated: true)
        }
        alertController.view.addSubview(pickerView)

        // NOTE: openradar.appspot.com/49289931
        // Currently, you will see "Unable to simultaneously satisfy constraints" when presenting a `UIAlertController`
        // with the preferred style of `.actionSheet`.

        // apply constraints
        let constants = theme.constants
        let baseDimension = constants.minimumTouchSize.width
        let baseInsetDimension = constants.menuBaseInsetDimension

        alertController.view.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alertController.view.heightAnchor.constraint(equalToConstant: baseDimension * 8),
            pickerView.topAnchor.constraint(equalTo: alertController.view.topAnchor,
                                            constant: baseInsetDimension * 3),
            pickerView.rightAnchor.constraint(equalTo: alertController.view.rightAnchor,
                                              constant: -baseInsetDimension),
            pickerView.leftAnchor.constraint(equalTo: alertController.view.leftAnchor,
                                             constant: baseInsetDimension),
            pickerView.heightAnchor.constraint(equalToConstant: baseDimension * 4.5)
        ])

        // add actions
        let action = UIAlertAction(title: displayable.pickerActionTitle, style: .default) { _ in
            let selectedIndices = (0..<pickerView.numberOfComponents).map { pickerView.selectedRow(inComponent: $0) }
            delegate.menuPickerFinished(pickerView: pickerView, selectedIndices: selectedIndices)
        }
        let cancelAction = UIAlertAction(title: displayable.pickerDismissTitle, style: .cancel, handler: nil)

        alertController.addAction(action)
        alertController.addAction(cancelAction)

        // present picker (menu) as an alert
        presentingVC.present(alertController, animated: true, completion: nil)
    }
}

 // MARK: - MenuPicker: UIPickerViewDataSource

extension MenuPicker: UIPickerViewDataSource {
    public final func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return displayable?.numberOfComponents ?? 0
    }

    public final func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return displayable?.numberOfRows(inComponent: component) ?? 0
    }
}

// MARK: - MenuPicker: UIPickerViewDelegate

extension MenuPicker: UIPickerViewDelegate {

    public final func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return theme?.constants.menuPickerRowHeight ?? 44
    }

    public final func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let widthFactor = displayable?.widthFactor(forComponent: component) ?? 1.0
        return pickerView.frame.width * widthFactor
    }

    public final func pickerView(_ pickerView: UIPickerView,
                                 viewForRow row: Int,
                                 forComponent component: Int,
                                 reusing view: UIView?) -> UIView {
        if let theme = theme {
            let colors = theme.colors
            let constants = theme.constants

            var label = UILabel(frame: CGRect(x: 0,
                                              y: 0,
                                              width: pickerView.frame.width,
                                              height: 0))

            if let currentView = view as? UILabel { label = currentView }

            let alignment = displayable?.titleAlignment(forRow: row, component: component) ?? .center
            let attributes = FontStyle.h4.attributesWith(textColor: colors.textMenuPickerRow,
                                                         alignment: alignment)
            let text = displayable?.title(forRow: row, component: component) ?? ""
            label.attributedText = NSAttributedString(string: text, attributes: attributes)
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = constants.menuPickerTextMinimumScaleFactor
            label.lineBreakMode = .byTruncatingTail

            return label
        } else {
            return UIView()
        }
    }
}
