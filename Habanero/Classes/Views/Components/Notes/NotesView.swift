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

    /// A custom amount of spacing to apply between notes within the `NotesView`.
    var customContentSpacing: CGFloat? { get }
}

// MARK: - NotesViewDelegate

public protocol NotesViewDelegate: class {
    func notesViewTappedNote(_ notesView: NotesView, backedValue: Any?)
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

    // MARK: Actions

    @objc func noteTapped(button: UIButton) {
        if let note = displayable?.notes[button.tag], case .link(let backedValue) = note.config {
            delegate?.notesViewTappedNote(self, backedValue: backedValue)
        }
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
        
        let insets = displayable.customContentInsets ?? constants.notesContentInsets
        mainStackView.isLayoutMarginsRelativeArrangement = true
        mainStackView.layoutMargins = displayable.isContentInset ? insets : .zero
        mainStackView.axis = .vertical
        mainStackView.spacing = displayable.customContentSpacing ?? constants.notesContentSpacing
        mainStackView.isHidden = false

        mainStackView.removeAllArrangedSubviews()
        for (index, note) in displayable.notes.enumerated() {
            switch note.config {
            case .link:
                let button = Button(frame: .zero, style: .text(.primary, .left))
                button.tag = index
                button.styleWith(theme: theme)
                button.setTitle(note.text, for: .normal)
                button.addTarget(self, action: #selector(noteTapped(button:)), for: .touchUpInside)
                mainStackView.addArrangedSubview(button)
            case .text(let fontStyle, let customTextColor, let indentation):
                let label = UILabel(frame: .zero)
                let textColor = customTextColor ?? colors.textHighEmphasis

                label.numberOfLines = 0
                label.attributedText = note.text.attributed(fontStyle: fontStyle,
                                                            color: textColor,
                                                            indentation: indentation ?? 0)
                mainStackView.addArrangedSubview(label)
            }
        }
    }
}
