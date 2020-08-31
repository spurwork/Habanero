//
//  ColorsVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/11/20.
//

import Habanero
import UIKit

// MARK: - ColorsVC: UITableViewController

class ColorsVC: UITableViewController {

    // MARK: Properties

    let theme = ThemeStandard()

    var colors: [ColorCellDisplayable] = []

    // MARK: Initializer

    init(colors: [ColorCellDisplayable]) {
        super.init(style: .plain)

        self.title = "Colors"
        self.colors = colors
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
        tableView.registerCellWithType(ColorCell.self)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ColorCell = tableView.dequeueReusableCellWithExplicitType(forIndexPath: indexPath,
                                                                            theme: theme)
        cell.styleWith(theme: theme, displayable: colors[indexPath.row])
        return cell
    }
}
