//
//  BaseTableVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/29/20.
//

import UIKit

// MARK: - TableVCSizer

protocol TableVCSizer: AnyObject {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
}

// MARK: - BaseTableVCSizer: TableVCSizer

class BaseTableVCSizer: TableVCSizer {

    // MARK: TableVCSizer

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

// MARK: - BaseTableVC: UITableViewController

class BaseTableVC: UITableViewController {

    // MARK: Properties

    var sizer: TableVCSizer

    // MARK: Initializer

    init(sizer: TableVCSizer) {
        self.sizer = sizer
        super.init(style: .plain)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UITableViewDelegate
    
    override final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sizer.tableView(tableView, heightForRowAt: indexPath)
    }

    override final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sizer.tableView(tableView, heightForHeaderInSection: section)
    }

    override final func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sizer.tableView(tableView, heightForFooterInSection: section)
    }

    override final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return sizer.tableView(tableView, estimatedHeightForRowAt: indexPath)
    }

    override final func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sizer.tableView(tableView, estimatedHeightForHeaderInSection: section)
    }

    override final func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return sizer.tableView(tableView, estimatedHeightForFooterInSection: section)
    }
}
