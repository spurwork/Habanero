//
//  MenuExample.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/10/20.
//

import Habanero
import UIKit

// MARK: - MenuExample: MenuDisplayable

struct MenuExample: MenuDisplayable {

    // MARK: Properties
    
    let options: [[String]]
    let tag: Int
    let style: SelectionGroupStyle = .single(.menu)
    
    var selectedIndices: (Int?, Int?)
    
    // MARK: MenuDisplayable
    
    var selectedValue: String? {
        guard selectedIndices.0 != nil, selectedIndices.1 != nil else { return nil }

        var value = ""
        
        if let firstIndex = selectedIndices.0 {
            value += options[0][firstIndex]
        } else {
            value += "Default"
        }
        
        if let secondIndex = selectedIndices.1 {
            value += ", \(options[1][secondIndex])"
        } else {
            value += ", Default"
        }
        
        return value
    }
    
    var placeholder: String {
        return "Choose colors."
    }
        
    var pickerTitle: String {
        return "Choose colors."
    }
    
    var pickerActionTitle: String {
        return MENU_PICKER_ACTION_TITLE
    }
    
    var pickerDismissTitle: String {
        return MENU_PICKER_DISMISS_TITLE
    }
    
    var numberOfComponents: Int {
        return options.count
    }
    
    func numberOfRows(inComponent component: Int) -> Int {
        return options[component].count
    }
    
    func defaultSelectedRow(forComponent component: Int) -> Int {
        if component == 0 {
            return selectedIndices.0 ?? 0
        } else {
            return selectedIndices.1 ?? 0
        }
    }
    
    func widthFactor(forComponent component: Int) -> CGFloat {
        return 0.5
    }
    
    func title(forRow row: Int, component: Int) -> String {
        return options[component][row]
    }
    
    func titleAlignment(forRow row: Int, component: Int) -> NSTextAlignment {
        return .center
    }
    
    // MARK: SelectionGroupDisplayable
           
    var selection: Selection = .single(nil)
    var choices: [SelectionControlDisplayable] {
        let selectedIndex = selection.selectedIndex
        return options[0].enumerated().map {
            SelectionControlExample(title: $1, tip: nil, tipLinkable: false, selected: $0 == selectedIndex)
        }
    }
}
