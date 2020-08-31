//
//  ActionListVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/11/20.
//

import Habanero
import UIKit

// MARK: - ActionListVCDelegate

protocol ActionListVCDelegate: class {
    func actionListVCTappedDismiss(_ actionListVC: ActionListVC)
    func actionListVCTappedRow(_ actionListVC: ActionListVC, row: Int)
}

// MARK: - ActionListVC: UITableViewController

class ActionListVC: UITableViewController {

    // MARK: Properties

    let theme: Theme
    var items: [ActionListCellDisplayable] = []

    weak var delegate: ActionListVCDelegate?

    // MARK: Initializer

    init(theme: Theme,
         title: String,
         items: [String],
         forceBackable: Bool = false) {
        self.theme = theme
        self.items = items.map { ActionListItem(icon: nil, title: $0, navigationStyle: .push) }

        super.init(style: .plain)
        finishInit(title: title, forceBackable: forceBackable)
    }
    
    init(theme: Theme,
         title: String,
         items: [ActionListCellDisplayable]) {
        self.theme = theme
        self.items = items

        super.init(style: .plain)

        finishInit(title: title, forceBackable: false)
    }
    
    private func finishInit(title: String, forceBackable: Bool) {
        self.title = title
        if forceBackable { addForceBackable() }
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
        tableView.registerCellWithType(ActionListCell.self)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActionListCell = tableView.dequeueReusableCellWithExplicitType(forIndexPath: indexPath,
                                                                                            theme: theme)
        cell.styleWith(theme: theme, displayable: items[indexPath.row])
        return cell
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.actionListVCTappedRow(self, row: indexPath.row)
    }
    
    // MARK: Helpers

    func addForceBackable() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(forceBackableTapped))
    }

    // MARK: Actions

    @objc func forceBackableTapped() {
        delegate?.actionListVCTappedDismiss(self)
    }
}
