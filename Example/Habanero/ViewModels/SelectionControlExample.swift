//
//  SelectionControlExample.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/10/20.
//

import Habanero

// MARK: - SelectionControlExample: SelectionControlDisplayable

struct SelectionControlExample: SelectionControlDisplayable {
    let title: String
    
    let tip: String?
    let tipLinkable: Bool
    
    let isSelected: Bool
    let isEnabled: Bool
}
