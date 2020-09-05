//
//  FooterExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 9/4/20.
//

import Habanero

// MARK: - FooterExamples: ExamplesVCDisplayable

struct FooterExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
    
    let titles: [String]
    let examples: [FooterDisplayable]
    let exampleViews: [UIView]
        
    // MARK: Initializer
    
    init(titles: [String], examples: [FooterDisplayable]) {
        self.titles = titles
        self.examples = examples
        exampleViews = examples.map { _ in Footer(frame: .zero) }
    }
    
    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let row = indexPath.row
        let footer = exampleViews[row]
        
        (footer as? Footer)?.styleWith(theme: theme, displayable: examples[row])
        return footer
    }
}

// MARK: - FooterExamples (Mock)

extension FooterExamples {
    static func mock(theme: Theme) -> FooterExamples {
        let titles = [
            "Footer (Left, Right)",
            "Footer (Center)"
        ]
        
        let examples: [FooterModel] = [
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .none),
            FooterModel(buttonState: .center("Center", .primary), content: .none)
        ]
        
        return FooterExamples(titles: titles, examples: examples)
    }
}
