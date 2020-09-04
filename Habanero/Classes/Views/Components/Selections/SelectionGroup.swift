// MARK: - SelectionGroupDisplayable

/// An object that can be displayed by a `SelectionGroup`.
public protocol SelectionGroupDisplayable {
    /// A tag identifying the `SelectionGroup`.
    var tag: Int { get }

    /// The current selection for the `SelectionGroup`.
    var selection: Selection { get set }

    /// The choices within the `SelectionGroup`.
    var choices: [SelectionControlDisplayable] { get }

    /// The style of the `SelectionGroup`.
    var style: SelectionGroupStyle { get }

    /// Is the `SelectionGroup` enabled?
    var isEnabled: Bool { get set }
}

// MARK: - SelectionGroupDelegate

public protocol SelectionGroupDelegate: class {
    func selectionGroupSelectionChanged(_ selectionGroup: SelectionGroup, selection: Selection)
    func selectionGroupShouldExpand(_ selectionGroup: SelectionGroup)
    func selectionGroupTipWasTapped(_ selectionGroup: SelectionGroup, selectionControl: SelectionControl)
}

// MARK: - SelectionGroup: BaseView

public class SelectionGroup: BaseView {

    // MARK: Properties

    private let choiceStack = UIStackView()

    private var theme: Theme?
    private var displayable: SelectionGroupDisplayable?

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "choiceStack": choiceStack
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[choiceStack]|",
            "V:|[choiceStack]|"
        ]
    }

    public weak var delegate: SelectionGroupDelegate?
    public var presentingVC: UIViewController?

    private var selectionControls: [SelectionControl] = []

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(choiceStack)
    }

    // MARK: Actions

    @objc func showMoreTapped() {
        delegate?.selectionGroupShouldExpand(self)
    }

    // MARK: Helpers

    private func replaceSubviews(theme: Theme, displayable: SelectionGroupDisplayable) {
        let constants = theme.constants

        choiceStack.removeAllArrangedSubviews()

        switch displayable.style {
        case .single(let singleStyle):
            switch singleStyle {
            case .menu: replaceSubviewsForMenu(displayable: displayable)
            case .allChoices: replaceSubviewsForAllChoices(displayable: displayable)
            case .topChoices(let expanded, let expandString):
                let totalChoices = displayable.choices.count
                if totalChoices > constants.selectionGroupTopChoicesMax {
                    replaceSubviewsForMenu(displayable: displayable)
                } else if totalChoices < constants.selectionGroupTopChoicesMin {
                    replaceSubviewsForAllChoices(displayable: displayable)
                } else {
                    replaceSubviewsForTopChoices(displayable: displayable,
                                                 expanded: expanded,
                                                 expandString: expandString)
                }
            case nil:
                (displayable.choices.count > constants.selectionGroupMenuChoiceThreshold) ?
                    replaceSubviewsForMenu(displayable: displayable) :
                    replaceSubviewsForAllChoices(displayable: displayable)
            }
        case .multi: replaceSubviewsForMultiSelect(displayable: displayable)
        }

        selectionControls = choiceStack.arrangedSubviews.compactMap { $0 as? SelectionControl }
    }

    private func replaceSubviewsForMenu(displayable: SelectionGroupDisplayable) {
        choiceStack.addArrangedSubview(Menu(frame: .zero, tag: displayable.tag, presentingVC: presentingVC))
    }

    private func replaceSubviewsForAllChoices(displayable: SelectionGroupDisplayable) {
        for index in displayable.choices.indices {
            let selectionControl = SelectionControl(frame: .zero, type: .radio)
            selectionControl.setControlTag(index)
            choiceStack.addArrangedSubview(selectionControl)
        }
    }

    private func replaceSubviewsForTopChoices(displayable: SelectionGroupDisplayable,
                                              expanded: Bool,
                                              expandString: String) {
        guard let theme = theme else { return }

        let topChoices = Int(ceil(Double(displayable.choices.count) * 0.25))

        for index in 0...topChoices {
            let selectionControl = SelectionControl(frame: .zero, type: .radio)
            selectionControl.setControlTag(index)
            choiceStack.addArrangedSubview(selectionControl)
        }

        if !expanded {
            let expandButton = UIButton.createShowMoreButton(theme: theme, title: expandString)
            expandButton.addTarget(self, action: #selector(showMoreTapped), for: .touchUpInside)
            choiceStack.addArrangedSubview(expandButton)
        }

        for index in (topChoices + 1)..<displayable.choices.count {
            let selectionControl = SelectionControl(frame: .zero, type: .radio)
            selectionControl.setControlTag(index)
            choiceStack.addArrangedSubview(selectionControl)
        }
    }

    private func replaceSubviewsForMultiSelect(displayable: SelectionGroupDisplayable) {
        for index in displayable.choices.indices {
            let selectionControl = SelectionControl(frame: .zero, type: .checkbox)
            selectionControl.setControlTag(index)
            choiceStack.addArrangedSubview(selectionControl)
        }
    }

    // MARK: Style

    public func styleWith(theme: Theme, displayable: SelectionGroupDisplayable) {
        guard !displayable.choices.isEmpty else { return }

        self.theme = theme

        tag = displayable.tag

        choiceStack.axis = .vertical
        choiceStack.isLayoutMarginsRelativeArrangement = true
        choiceStack.layoutMargins = .zero
        choiceStack.spacing = theme.constants.selectionGroupChoiceSpacing
        choiceStack.distribution = .fillEqually

        // replace subviews, if necessary
        if let lastDisplayable = self.displayable,
            lastDisplayable.style != displayable.style,
            lastDisplayable.tag != lastDisplayable.tag {
            replaceSubviews(theme: theme, displayable: displayable)
        } else {
            replaceSubviews(theme: theme, displayable: displayable)
        }
        self.displayable = displayable

        // style subviews
        styleSubviews(theme: theme, displayable: displayable)
    }

    private func styleSubviews(theme: Theme, displayable: SelectionGroupDisplayable) {
        let constants = theme.constants

        switch displayable.style {
        case .single(let singleStyle):
            switch singleStyle {
            case .menu:
                styleAsMenu(theme: theme, displayable: displayable)
            case .allChoices:
                styleChoices(theme: theme, displayable: displayable)
            case .topChoices(let expanded, _):
                let totalChoices = displayable.choices.count
                if totalChoices > constants.selectionGroupTopChoicesMax {
                    styleAsMenu(theme: theme, displayable: displayable)
                } else if totalChoices < constants.selectionGroupTopChoicesMin {
                    styleChoices(theme: theme, displayable: displayable)
                } else {
                    styleChoices(theme: theme, displayable: displayable, showAll: expanded)
                }
            case nil:
                (displayable.choices.count > constants.selectionGroupMenuChoiceThreshold) ?
                    styleAsMenu(theme: theme, displayable: displayable) :
                    styleChoices(theme: theme, displayable: displayable)
            }
        case .multi: styleChoices(theme: theme, displayable: displayable)
        }
    }

    private func styleAsMenu(theme: Theme, displayable: SelectionGroupDisplayable) {
        guard let menuDisplayable = displayable as? MenuDisplayable else { return }

        let menu = choiceStack.arrangedSubviews.compactMap { $0 as? Menu }.first
        menu?.pickerDelegate = self
        menu?.styleWith(theme: theme, displayable: menuDisplayable)
    }

    private func styleChoices(theme: Theme, displayable: SelectionGroupDisplayable, showAll: Bool = true) {
        let selectedIndices = displayable.selection.selectedIndices
        let topChoices = Int(ceil(Double(displayable.choices.count) * 0.25))
        let selectionControls = choiceStack.arrangedSubviews.compactMap { $0 as? SelectionControl }

        for (index, choice) in displayable.choices.enumerated() {
            let selectionControl = selectionControls[index]
            let displayable = SimpleSelectionControl(title: choice.title,
                                                     tip: choice.tip,
                                                     tipLinkable: choice.tipLinkable,
                                                     isSelected: selectedIndices.contains(index),
                                                     isEnabled: displayable.isEnabled)

            selectionControl.delegate = self
            selectionControl.tipDelegate = self

            selectionControl.styleWith(theme: theme, displayable: displayable)
            selectionControl.isHidden = showAll ? false : (index > topChoices)
        }

        let expandView = choiceStack.arrangedSubviews.first { $0 is UIButton }
        if let expandView = expandView, let expandButton = expandView as? UIButton, !showAll {
            let colors = theme.colors
            expandButton.isEnabled = displayable.isEnabled
            expandButton.tintColor = displayable.isEnabled ?
                colors.tintButtonImagePrimary : colors.tintButtonImageDisabled
        }
    }
}

// MARK: - SelectionGroup: SelectionControlDelegate

extension SelectionGroup: SelectionControlDelegate {
    public func selectionControlWasTapped(_ selectionControl: SelectionControl) {
        guard let displayable = displayable, let theme = theme else { return }
        let constants = theme.constants

        switch displayable.style {
        case .single(.allChoices), .single(.topChoices):
            selectControlSingle(selectionControl)
        case .single(nil):
            if displayable.choices.count > constants.selectionGroupMenuChoiceThreshold {
                return
            } else {
                selectControlSingle(selectionControl)
            }
        case .single(.menu):
            return
        case .multi:
            selectControlMulti(selectionControl)
        }
    }

    private func selectControlSingle(_ selectionControl: SelectionControl) {
        delegate?.selectionGroupSelectionChanged(self, selection: .single(selectionControl.getControlTag()))
    }

    private func selectControlMulti(_ selectionControl: SelectionControl) {
        guard let displayable = displayable else { return }

        if case .multi(let currentlySelectedIndices) = displayable.selection {
            let updatingIndex = selectionControl.getControlTag()
            var newIndices = Set(currentlySelectedIndices)
            if newIndices.contains(updatingIndex) {
                newIndices.remove(updatingIndex)
            } else {
                newIndices.insert(updatingIndex)
            }

            delegate?.selectionGroupSelectionChanged(self, selection: .multi(Array(newIndices)))
        }
    }
}

// MARK: - SelectionGroup: SelectionControlTipDelegate

extension SelectionGroup: SelectionControlTipDelegate {
    public func selectionControlTipWasTapped(_ selectionControl: SelectionControl) {
        guard let selectionControlDisplayable = selectionControl.displayable else { return }

        if selectionControlDisplayable.tipLinkable {
            delegate?.selectionGroupTipWasTapped(self, selectionControl: selectionControl)
        } else {
            selectionControlWasTapped(selectionControl)
        }
    }
}

// MARK: - SelectionGroup: MenuPickerDelegate

extension SelectionGroup: MenuPickerDelegate {
    public func menuPickerFinished(pickerView: UIPickerView, selectedIndices: [Int]) {
        guard !selectedIndices.isEmpty else { return }
        delegate?.selectionGroupSelectionChanged(self, selection: .single(selectedIndices[0]))
    }
}
