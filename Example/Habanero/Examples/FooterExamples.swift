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
            "Buttons: None, Content: None",
            "Buttons: None, Content: Label",
            "Buttons: None, Content: Label (Tappable)",
            "Buttons: LeftRight, Content: None",
            "Buttons: LeftRight, Content: Label",
            "Buttons: LeftRight, Content: Label (Tappable)",
            "Buttons: Center, Content: None",
            "Buttons: Center, Content: Label",
            "Buttons: Center, Content: Label (Tappable)",
        ]
        
        let examples: [FooterModel] = [
            FooterModel(buttonState: .none, content: .none),
            FooterModel(buttonState: .none, content: .label(FooterLabel(text: "Label", icon: "🎁", isTappable: false))),
            FooterModel(buttonState: .none, content: .label(FooterLabel(text: "Label", icon: "🎁", isTappable: true))),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .none),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .label(FooterLabel(text: "Label", icon: "🎁", isTappable: false))),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .label(FooterLabel(text: "Label", icon: "🎁", isTappable: true))),
            FooterModel(buttonState: .center("Center", .primary), content: .none),
            FooterModel(buttonState: .center("Center", .primary), content: .label(FooterLabel(text: "Label", icon: "🎁", isTappable: false))),
            FooterModel(buttonState: .center("Center", .primary), content: .label(FooterLabel(text: "Label", icon: "🎁", isTappable: true))),
        ]
        
        return FooterExamples(titles: titles, examples: examples)
    }
}
