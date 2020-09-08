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
            "Buttons: None, Content: Checkbox",
            "Buttons: None, Content: Checkbox (Tip)",
            "Buttons: LeftRight, Content: None",
            "Buttons: LeftRight, Content: Label",
            "Buttons: LeftRight, Content: Label (Tappable)",
            "Buttons: LeftRight, Content: Checkbox",
            "Buttons: LeftRight, Content: Checkbox (Tip)",
            "Buttons: Center, Content: None",
            "Buttons: Center, Content: Label",
            "Buttons: Center, Content: Label (Tappable)",
            "Buttons: Center, Content: Checkbox",
            "Buttons: Center, Content: Checkbox (Tip)",
        ]
        
        let footerLabel = FooterLabel(text: "Label", icon: "🎁", isTappable: false)
        let footerLabelTappable = FooterLabel(text: "Label", icon: "🎁", isTappable: true)
        let checkbox = SelectionControlExample(title: "Checkbox", tip: nil, tipLinkable: false, isSelected: false, isEnabled: true)
        let checkboxTip = SelectionControlExample(title: "Checkbox", tip: "This is a tip.", tipLinkable: true, isSelected: false, isEnabled: true)
        
        let examples: [FooterModel] = [
            FooterModel(buttonState: .none, content: .none),
            FooterModel(buttonState: .none, content: .label(footerLabel)),
            FooterModel(buttonState: .none, content: .label(footerLabelTappable)),
            FooterModel(buttonState: .none, content: .checkbox(checkbox, nil)),
            FooterModel(buttonState: .none, content: .checkbox(checkboxTip, nil)),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .none),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .label(footerLabel)),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .label(footerLabelTappable)),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .checkbox(checkbox, nil)),
            FooterModel(buttonState: .leftRight("Left", "Right", .primary), content: .checkbox(checkboxTip, nil)),
            FooterModel(buttonState: .center("Center", .primary), content: .none),
            FooterModel(buttonState: .center("Center", .primary), content: .label(footerLabel)),
            FooterModel(buttonState: .center("Center", .primary), content: .label(footerLabelTappable)),
            FooterModel(buttonState: .center("Center", .primary), content: .checkbox(checkbox, nil)),
            FooterModel(buttonState: .center("Center", .primary), content: .checkbox(checkboxTip, nil)),
        ]
        
        return FooterExamples(titles: titles, examples: examples)
    }
}
