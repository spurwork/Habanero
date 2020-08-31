//
//  AlertExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 8/18/20.
//

import Habanero

// MARK: - AlertExamples: ExamplesVCDisplayable

struct AlertExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
    
    let titles: [String]
    let exampleViews: [UIView]
    
    let examples: [Alert]
    
    init(theme: Theme, titles: [String], types: [AlertType]) {
        self.titles = titles
        self.examples = types.map { Alert(type: $0,
                                          message: "Alert message.",
                                          duration: 2.0,
                                          anchor: .bottom) }
        
        exampleViews = examples.map { _ in AlertView(frame: .zero) }
    }
    
    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let alert = exampleViews[indexPath.row]
        (alert as? AlertView)?.styleWith(theme: theme, displayable: examples[indexPath.row])
        return alert
    }
}

// MARK: - AlertExamples (Mock)

extension AlertExamples {
    static func mock(theme: Theme) -> AlertExamples {
        return AlertExamples(theme: theme,
                             titles: ["Error", "Information", "Success"],
                             types: [.error, .info, .success])
    }
}
