//
//  ButtonExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/30/20.
//

import Habanero

// MARK: - ButtonExamples: ExamplesVCDisplayable

struct ButtonExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
    
    let styles: [(String, ButtonStyle)]
    let exampleViews: [UIView]
    
    var titles: [String] { return styles.map { $0.0 } }
    
    // MARK: Initializer
    
    init(styles: [(String, ButtonStyle)]) {
        self.styles = styles
        exampleViews = styles.map { Button(frame: .zero, style: $0.1) }
    }
    
    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let button = exampleViews[indexPath.row]
        (button as? Button)?.styleWith(theme: theme)
        (button as? Button)?.setTitle(BUTTON_TEXT, for: .normal)
        return button
    }
}

// MARK: - ButtonExamples (Mock)

extension ButtonExamples {
    static func mock(theme: Theme) -> ButtonExamples {
        return ButtonExamples(styles: [
            ("Contained: Primary", .contained(.primary)),
            ("Contained: Secondary 1", .contained(.secondary1)),
            ("Contained: Secondary 2", .contained(.secondary2)),
            ("Contained: Secondary 3", .contained(.secondary3)),
            ("Contained: Secondary 4", .contained(.secondary4)),
            ("Contained: Secondary 5", .contained(.secondary5)),
            ("Outline: Primary", .outline(.primary)),
            ("Outline: Secondary 0", .outline(.secondary0)),
            ("Outline: Secondary 1", .outline(.secondary1)),
            ("Outline: Secondary 2", .outline(.secondary2)),
            ("Outline: Secondary 3", .outline(.secondary3)),
            ("Outline: Secondary 4", .outline(.secondary4)),
            ("Outline: Secondary 5", .outline(.secondary5)),
            ("Text: Primary", .text(.primary, .center)),
            ("Text: Secondary", .text(.secondary, .center))
        ])
    }
}

