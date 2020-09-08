// MARK: - NotesViewDisplayable

/// An object that can be displayed by a `NotesView`.
public protocol NotesViewDisplayable {
    /// A list of notes to display within a `NotesView`.
    var notes: [Note] { get }

    /// Should the list of notes use a background?
    var useBackground: Bool { get }
}

// MARK: - NotesViewDelegate

public protocol NotesViewDelegate: class {
    func notesViewTappedLink(_ notesView: NotesView, link: String)
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
        backgroundColor = colors.backgroundDivider

        mainStackView.isHidden = false
        if !mainStackView.isLayoutMarginsRelativeArrangement {
            mainStackView.isLayoutMarginsRelativeArrangement = true
            mainStackView.layoutMargins = displayable.useBackground ? constants.notesContentInsets : .zero
            mainStackView.axis = .vertical
            mainStackView.spacing = constants.notesContentSpacing
        }

        for (index, note) in displayable.notes.enumerated() {
            let selectionLabel = SelectionLabel(frame: .zero)
            let normalColor = (note.link != nil) ? colors.textNotesLink : colors.textHighEmphasis
            let textColor = note.customTextColor ?? normalColor

            selectionLabel.tag = index
            selectionLabel.delegate = (note.link == nil) ? nil : self
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
        if let link = displayable?.notes[selectionLabel.tag].link {
            delegate?.notesViewTappedLink(self, link: link)
        }
    }

    func selectionLabelWasTouchedDown(_ selectionLabel: SelectionLabel) {}
}
