//
//  Icon.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/11/20.
//

import Habanero
import UIKit

// MARK: - Icon

struct Icon {

    // MARK: Properties

    let name: String
    let image: UIImage?
}

// MARK: - Icon: ActionListCellDisplayable

extension Icon: ActionListCellDisplayable {    
    var icon: UIImage? { return image }
    var title: String { return name }
        
    var subtitle: String? { return nil }
    var accessoryStyle: ActionListAccessoryViews { return .none }
    var customIconTintColor: UIColor? { return nil }
    var customTitleTextColor: UIColor? { return nil }
    var customBackgroundColor: UIColor? { return nil }
}
