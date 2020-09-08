// MARK: - NotesViewDisplayable

/// An object that can be displayed by a `NotesView`.
public protocol NotesViewDisplayable {
    /// A list of notes to display within a `NotesView`.
    var notes: [Note] { get }
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

        layer.cornerRadius = theme.constants.notesViewCornerRadius
        backgroundColor = colors.backgroundDivider

        // TODO: remove magic
        mainStackView.isHidden = false
        if !mainStackView.isLayoutMarginsRelativeArrangement {
            mainStackView.isLayoutMarginsRelativeArrangement = true
            mainStackView.layoutMargins = UIEdgeInsets(uniform: 16)
            mainStackView.axis = .vertical
            mainStackView.spacing = 8
        }

        for (index, note) in displayable.notes.enumerated() {
            let selectionLabel = SelectionLabel(frame: .zero)
            // TODO: if link provided, then use link color if custom text color isn't provided
            let textColor = note.customTextColor ?? colors.textHighEmphasis

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
