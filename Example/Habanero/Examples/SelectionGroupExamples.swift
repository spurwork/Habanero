//
//  SelectionGroupExamples.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/30/20.
//

import Habanero

// MARK: - SelectionGroupExamples: ExamplesVCDisplayable

struct SelectionGroupExamples: ExamplesVCDisplayable {
    
    // MARK: Properties
    
    let titles: [String]
    let examples: [SelectionGroupDisplayable]
    let exampleViews: [UIView]
    
    // MARK: Initializer
    
    init(titles: [String], examples: [SelectionGroupDisplayable]) {
        self.titles = titles
        self.examples = examples
        exampleViews = examples.map { _ in SelectionGroup(frame: .zero) }
    }
    
    // MARK: ExamplesVCDisplayable
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView {
        let selectionGroup = exampleViews[indexPath.row]
        (selectionGroup as? SelectionGroup)?.styleWith(theme: theme, displayable: examples[indexPath.row])
        return selectionGroup
    }
}

// MARK: - SelectionGroupExamples (Mock)

extension SelectionGroupExamples {
    static func mock(theme: Theme) -> SelectionGroupExamples {
        return SelectionGroupExamples(titles: [
            "Single-Select: All Choices",
            "Single-Select: All Choices, Disabled",
            "Single-Select: All Choices, Selected",
            "Single-Select: Menu",
            "Single-Select: Menu, Disabled",
            "Single-Select: Menu, Selected",
            "Single-Select: Top Choices",
            "Single-Select: Top Choices, Disabled",
            "Single-Select: Top Choices, Expanded",
            "Multi-Select",
            "Multi-Select, Selected"
            ], examples: [
                SelectionGroupExample.mock(theme: theme, tag: 0, numberOfOptions: 3, singleStyle: .allChoices, selectedIndex: nil),
                SelectionGroupExample.mock(theme: theme, tag: 1, numberOfOptions: 3, singleStyle: .allChoices, selectedIndex: nil, isEnabled: false),
                SelectionGroupExample.mock(theme: theme, tag: 2, numberOfOptions: 3, singleStyle: .allChoices, selectedIndex: 0),
                SelectionGroupExample.mock(theme: theme, tag: 3, numberOfOptions: 3, singleStyle: .menu, selectedIndex: nil),
                SelectionGroupExample.mock(theme: theme, tag: 4, numberOfOptions: 3, singleStyle: .menu, selectedIndex: nil, isEnabled: false),
                SelectionGroupExample.mock(theme: theme, tag: 5, numberOfOptions: 3, singleStyle: .menu, selectedIndex: 0),
                SelectionGroupExample.mock(theme: theme, tag: 6, numberOfOptions: 10, singleStyle: .topChoices(false, SELECTION_GROUP_EXPAND_TITLE), selectedIndex: nil),
                SelectionGroupExample.mock(theme: theme, tag: 7, numberOfOptions: 10, singleStyle: .topChoices(false, SELECTION_GROUP_EXPAND_TITLE), selectedIndex: nil, isEnabled: false),
                SelectionGroupExample.mock(theme: theme, tag: 8, numberOfOptions: 10, singleStyle: .topChoices(true, SELECTION_GROUP_EXPAND_TITLE), selectedIndex: nil),
                SelectionGroupExample.mock(theme: theme, tag: 9, numberOfOptions: 3, selectedIndices: []),
                SelectionGroupExample.mock(theme: theme, tag: 10, numberOfOptions: 3, selectedIndices: [0, 1])
        ])
    }
}
