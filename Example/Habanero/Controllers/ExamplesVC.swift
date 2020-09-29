//
//  ExamplesVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/29/20.
//

import Habanero
import UIKit

// MARK: - ExamplesVCDisplayable

protocol ExamplesVCDisplayable {
    var titles: [String] { get }
    var exampleViews: [UIView] { get }
    
    func exampleView(theme: Theme, indexPath: IndexPath) -> UIView
}

// MARK: - ExamplesVC: BaseTableVC

class ExamplesVC: BaseTableVC {
    
    // MARK: Properties
    
    let theme: Theme
    let displayable: ExamplesVCDisplayable
    
    // MARK: Initializer
    
    init(theme: Theme,
         sizer: TableVCSizer,
         title: String,
         displayable: ExamplesVCDisplayable,
         forceBackable: Bool = false) {
        self.theme = theme
        self.displayable = displayable
        
        super.init(sizer: sizer)
        self.title = title
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = theme.colors
        view.backgroundColor = colors.backgroundCell
        
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.registerCellWithType(ExampleCell.self)
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayable.exampleViews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ExampleCell = tableView.dequeueReusableCellWithExplicitType(forIndexPath: indexPath,
                                                                              theme: theme)
        
        let contentView = displayable.exampleView(theme: theme, indexPath: indexPath)
        cell.styleWith(theme: theme, title: displayable.titles[indexPath.row], contentView: contentView)
        
        return cell
    }
}

// MARK: - ExamplesVC (Mock)

extension ExamplesVC {
    static func alerts(theme: Theme) -> ExamplesVC {
        return ExamplesVC(theme: theme,
                          sizer: BaseTableVCSizer(),
                          title: "Alerts (Styles)",
                          displayable: AlertExamples.mock(theme: theme))
    }
    
    static func buttons(theme: Theme) -> ExamplesVC {
        return ExamplesVC(theme: theme,
                          sizer: BaseTableVCSizer(),
                          title: "Button (Styles)",
                          displayable: ButtonExamples.mock(theme: theme))
    }
    
    static func notesViews(theme: Theme) -> ExamplesVC {
        return ExamplesVC(theme: theme,
                          sizer: BaseTableVCSizer(),
                          title: "Notes (Styles)",
                          displayable: NotesViewExamples.mock(theme: theme))
    }
    
    static func selectionGroups(theme: Theme) -> ExamplesVC {
        let examples = SelectionGroupExamples.mock(theme: theme)
        let examplesVC = ExamplesVC(theme: theme,
                                    sizer: BaseTableVCSizer(),
                                    title: "Selection Group (Styles)",
                                    displayable: examples)
        _ = examples.exampleViews.map { ($0 as? SelectionGroup)?.presentingVC = examplesVC }
        return examplesVC
    }
    
    static func statusViews(theme: Theme) -> ExamplesVC {
        return ExamplesVC(theme: theme,
                          sizer: BaseTableVCSizer(),
                          title: "Status Views (Styles)",
                          displayable: StatusViewExamples.mock(theme: theme))
    }
    
    static func textInputs(theme: Theme) -> ExamplesVC {
        return ExamplesVC(theme: theme,
                          sizer: BaseTableVCSizer(),
                          title: "Text Input (Styles)",
                          displayable: TextInputExamples.mock(theme: theme))
    }
}
