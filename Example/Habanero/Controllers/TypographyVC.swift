//
//  TypographyVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/11/20.
//

import Habanero
import UIKit

// MARK: - TypographyVC: UITableViewController

class TypographyVC: UITableViewController {

    // MARK: Properties

    let theme = ThemeStandard()

    var fontStyles: [TypographyCellDisplayable] = []

    // MARK: Initializer

    init(fontStyles: [TypographyCellDisplayable]) {
        super.init(style: .plain)

        self.title = "Typographic Scale"
        self.fontStyles = fontStyles
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let colors = theme.colors
        view.backgroundColor = colors.backgroundCell
        
        tableView.separatorInset = .zero
        tableView.registerCellWithType(TypographyCell.self)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontStyles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TypographyCell = tableView.dequeueReusableCellWithExplicitType(forIndexPath: indexPath,
                                                                                 theme: theme)
        cell.styleWith(theme: theme, displayable: fontStyles[indexPath.row])
        return cell
    }
}
