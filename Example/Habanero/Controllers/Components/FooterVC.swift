//
//  FooterVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 9/5/20.
//

import Habanero
import UIKit

// MARK: - FooterVC: UITableViewController

class FooterVC: UITableViewController {
    
    // MARK: Properties
    
    let theme: Theme
    let footer = Footer(frame: .zero)
            
    // MARK: Initializer
    
    init(theme: Theme) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
        title = "Footer"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.colors.backgroundCell
        
        tableView.separatorInset = .zero
        tableView.registerCellWithType(ActionListCell.self)
        
        let checkbox = SelectionControlExample(title: "Checkbox",
                                               tip: "A link to something.",
                                               tipLinkable: true,
                                               isSelected: false,
                                               isEnabled: true)
        
        footer.delegate = self
        footer.styleWith(theme: theme, displayable: FooterModel(buttonState: .center("Center", .primary),
                                                                content: .checkbox(checkbox, "https://spurwork.com")))
        
        view.addSubview(footer)
    }
    
    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActionListCell = tableView.dequeueReusableCellWithExplicitType(forIndexPath: indexPath,
                                                                            theme: theme)
        cell.styleWith(theme: theme, displayable: ActionListItem(icon: nil, title: "Title \(indexPath.row)", navigationStyle: .none))
        return cell
    }
}

// MARK: - FooterVC: FooterDelegate

extension FooterVC: FooterDelegate {
    func footerButtonWasTapped(_ footer: Footer, position: FooterButtonPosition) {
        print("footer button at \(position) was tapped")
    }
    
    func footerLabelWasTapped(_ footer: Footer) {
        print("footer label was tapped")
    }
    
    func footerCheckboxWasTapped(_ footer: Footer) {
        print("footer checkbox was tapped")
    }
    
    func footerTipWasTapped(_ footer: Footer, backedValue: Any) {
        print(backedValue)
    }
}
