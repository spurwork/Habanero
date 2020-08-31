//
//  TextInputExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/30/20.
//

import Habanero

// MARK: - TextInputExamples: ExamplesVCDisplayable

struct TextInputExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
    
    let titles: [String]
    let examples: [TextInputDisplayable]
    let exampleViews: [UIView]
    
    init(titles: [String], examples: [TextInputDisplayable]) {
        self.titles = titles
        self.examples = examples
        exampleViews = examples.map { _ in TextInput(frame: .zero) }
    }

    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let textInput = exampleViews[indexPath.row]
        (textInput as? TextInput)?.styleWith(theme: theme, displayable: examples[indexPath.row])
        return textInput
    }
}

// MARK: - TextInputExamples (Mock)

extension TextInputExamples {
    static func mock(theme: Theme) -> TextInputExamples {
        return TextInputExamples(titles: [
            "Single",
            "Multiline"
        ], examples: TextInputExample.mock(theme: theme))
    }
}
