//
//  ButtonsVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/4/20.
//

import Habanero
import UIKit

// MARK: - ButtonsVC: StateSwappingVC

class ButtonsVC: StateSwappingVC {

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Buttons"

        controls = getExampleButtons()

        for control in controls {
            if let button = control as? UIButton {
                button.setTitle(BUTTON_TEXT, for: .normal)
            }
            view.addSubview(control)
        }
        
        textField0.placeholder = BUTTON_TEXT
        textField1.isHidden = true
    }
    
    // MARK: Helpers
    
    open func getExampleButtons() -> [UIButton] { return [] }
    
    override func textFieldHasUpdated(text: String, tag: Int) {
        _ = controls.map { ($0 as? UIButton)?.setTitle(text, for: .normal) }
    }
}
