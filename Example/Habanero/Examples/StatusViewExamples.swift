//
//  StatusViewExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 8/17/20.
//

import Habanero

// MARK: - StatusViewExamples: ExamplesVCDisplayable

struct StatusViewExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
        
    let styles: [(String, StatusType)]
    let exampleViews: [UIView]
    
    var titles: [String] { return styles.map { $0.0 } }
    
    // MARK: Initializer
    
    init(styles: [(String, StatusType)]) {
        self.styles = styles
        exampleViews = styles.map { _ in StatusView(frame: .zero) }
    }
    
    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let style = styles[indexPath.row]
        let view = exampleViews[indexPath.row]
        (view as? StatusView)?.styleWith(theme: theme,
                                         displayable: SimpleStatus(status: style.0, type: style.1))
        return view
    }
}

// MARK: - StatusViewExamples (Mock)

extension StatusViewExamples {
    static func mock(theme: Theme) -> StatusViewExamples {
        return StatusViewExamples(styles: [
            ("Alert", .alert),
            ("Inactive", .inactive),
            ("Normal", .normal),
            ("Selected", .selected),
            ("Success", .success),
            ("Warning", .warning)
        ])
    }
}


