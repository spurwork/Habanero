//
//  NotesViewExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 9/8/20.
//

import Habanero

// MARK: - NotesViewExamples: ExamplesVCDisplayable

struct NotesViewExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
    
    let titles: [String]
    let examples: [NotesViewDisplayable]
    let exampleViews: [UIView]
        
    // MARK: Initializer
    
    init(titles: [String], examples: [NotesViewDisplayable]) {
        self.titles = titles
        self.examples = examples
        exampleViews = examples.map { _ in NotesView(frame: .zero) }
    }
    
    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let row = indexPath.row
        let notesView = exampleViews[row]
        
        (notesView as? NotesView)?.styleWith(theme: theme, displayable: examples[row])
        return notesView
    }
}

// MARK: - NotesViewExamples (Mock)

extension NotesViewExamples {
    static func mock(theme: Theme) -> NotesViewExamples {
        let titles = [
            "Notes: Empty",
            "Notes: Text (No Background)",
            "Notes: Text (No Background, Inset)",
            "Notes: Text",
            "Notes: Text, Link",
            "Notes: Title, Text",
            "Notes: Link",
        ]
        
        let examples: [NotesViewDisplayable] = [
            Notes(notes: []),
            Notes(notes: [Note(fontStyle: .bodyLarge, value: "Some body text.")],
                  showBackground: false,
                  isContentInset: false,
                  customContentInsets: nil),
            Notes(notes: [Note(fontStyle: .bodyLarge, value: "Some body text.")],
                  showBackground: false,
                  isContentInset: true,
                  customContentInsets: nil),
            Notes(notes: [
                Note(fontStyle: .bodyLarge, value: "Some body text."),
                Note(fontStyle: .bodyLarge, value: "Some body text."),
                Note(fontStyle: .bodyLarge, value: "Some body text.")
            ]),
            Notes(notes: [
                Note(fontStyle: .bodyLarge, value: "Some body text about a website."),
                Note(fontStyle: .labelSmall, value: "A link to website.", link: "https://spurwork.com")
            ]),
            Notes(notes: [
                Note(fontStyle: .labelLarge, value: "Section Title"),
                Note(fontStyle: .bodyLarge, value: "Some body text about the section.")
            ]),
            Notes(notes: [
                Note(fontStyle: .labelLarge, value: "Contact Support", link: "https://spurwork.com")                
            ])
        ]
        
        return NotesViewExamples(titles: titles, examples: examples)
    }
}

