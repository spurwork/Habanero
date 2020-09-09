// MARK: - NotesViewDisplayable

/// An object that can be displayed by a `NotesView`.
public protocol NotesViewDisplayable {
    /// A list of notes to display within a `NotesView`.
    var notes: [Note] { get }

    /// Should the background color be shown?
    var showBackground: Bool { get }

    /// Should the content be inset?
    var isContentInset: Bool { get }

    /// A custom amount of spacing to apply to the `NotesView`.
    var customContentInsets: UIEdgeInsets? { get }
}

// MARK: - NotesViewDelegate

public protocol NotesViewDelegate: class {
    func notesViewTappedLabel(_ notesView: NotesView, backedValue: String?)
}

// MARK: - NotesView: BaseView

public class NotesView: BaseView {

    // MARK: Properties

    private let mainStackView = UIStackView(frame: .zero)

    public override var visualConstraintViews: [String: AnyObject] {
        return [
            "mainStackView": mainStackView
        ]
    }

    public override var visualConstraints: [String] {
        return [
            "H:|[mainStackView]|",
            "V:|[mainStackView]|"
        ]
    }

    private var displayable: NotesViewDisplayable?

    public weak var delegate: NotesViewDelegate?

    // MARK: BaseView

    public override func addSubviews() {
        addSubview(mainStackView)
    }

    // MARK: Custom Styling

    public func styleWith(theme: Theme, displayable: NotesViewDisplayable) {
        self.displayable = displayable

        guard !displayable.notes.isEmpty else {
            mainStackView.isHidden = true
            return
        }

        let colors = theme.colors
        let constants = theme.constants

        layer.cornerRadius = constants.notesViewCornerRadius
        backgroundColor = displayable.showBackground ? colors.backgroundNotes : nil

        mainStackView.isHidden = false
        if !mainStackView.isLayoutMarginsRelativeArrangement {
            let insets = displayable.customContentInsets ?? constants.notesContentInsets
            mainStackView.isLayoutMarginsRelativeArrangement = true
            mainStackView.layoutMargins = displayable.isContentInset ? insets : .zero
            mainStackView.axis = .vertical
            mainStackView.spacing = constants.notesContentSpacing
        }

        mainStackView.removeAllArrangedSubviews()
        for (index, note) in displayable.notes.enumerated() {
            let selectionLabel = SelectionLabel(frame: .zero)
            let normalColor = (note.backedValue != nil) ? colors.textNotesLink : colors.textHighEmphasis
            let textColor = note.customTextColor ?? normalColor

            selectionLabel.tag = index
            selectionLabel.delegate = self
            selectionLabel.label.numberOfLines = 0
            selectionLabel.label.attributedText = note.value.attributed(fontStyle: note.fontStyle,
                                                                        color: textColor,
                                                                        indentation: note.indentation)
            mainStackView.addArrangedSubview(selectionLabel)
        }
    }
}

// MARK: - NotesView: SelectionLabelDelegate

extension NotesView: SelectionLabelDelegate {
    func selectionLabelWasTouchedUp(_ selectionLabel: SelectionLabel) {
        if let note = displayable?.notes[selectionLabel.tag] {
            delegate?.notesViewTappedLabel(self, backedValue: note.backedValue)
        }
    }

    func selectionLabelWasTouchedDown(_ selectionLabel: SelectionLabel) {}
}
