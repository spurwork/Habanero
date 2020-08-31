//
//  MenuPickerExample.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/10/20.
//

import Habanero
import UIKit

// MARK: - MenuPickerExample: MenuPickerDisplayable

struct MenuPickerExample: MenuPickerDisplayable {
    var pickerTitle: String { return MENU_PICKER_CUSTOM_TITLE }
    var pickerActionTitle: String { return MENU_PICKER_ACTION_TITLE }
    var pickerDismissTitle: String { return MENU_PICKER_DISMISS_TITLE }
    var numberOfComponents: Int { return 1 }
    
    func numberOfRows(inComponent component: Int) -> Int {
        return 3
    }
    
    func defaultSelectedRow(forComponent component: Int) -> Int {
        return 0
    }
    
    func widthFactor(forComponent component: Int) -> CGFloat {
        return 1.0
    }
    
    func title(forRow row: Int, component: Int) -> String {
        switch row {
        case 0: return "Selection Selection Selection Selection Selection LongString LongString LongString LongString LongString Really Really Really Really Really"
        case 1: return "Isn't"
        default: return "Saved"
        }
    }
    
    func titleAlignment(forRow row: Int, component: Int) -> NSTextAlignment {
        return .center
    }
}
