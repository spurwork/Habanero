//
//  ButtonsContainedVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 05/06/2020.
//

import Habanero
import UIKit

// MARK: - ButtonsContainedVC: ButtonsVC

class ButtonsContainedVC: ButtonsVC {

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contained Button"
    }
    
    // MARK: ButtonsVC
        
    override func getExampleButtons() -> [UIButton] {
         let containedButtonPrimary = Button(frame: CGRect(x: 20, y: 120, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .contained(.primary))
         containedButtonPrimary.styleWith(theme: theme)
         
         let containedButtonSecondary1 = Button(frame: CGRect(x: 200, y: 120, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .contained(.secondary1))
         containedButtonSecondary1.styleWith(theme: theme)
         
         let containedButtonSecondary2 = Button(frame: CGRect(x: 20, y: 170, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .contained(.secondary2))
         containedButtonSecondary2.styleWith(theme: theme)
         
         let containedButtonSecondary3 = Button(frame: CGRect(x: 200, y: 170, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .contained(.secondary3))
         containedButtonSecondary3.styleWith(theme: theme)
         
         let containedButtonSecondary4 = Button(frame: CGRect(x: 20, y: 220, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .contained(.secondary4))
         containedButtonSecondary4.styleWith(theme: theme)
         
         let containedButtonSecondary5 = Button(frame: CGRect(x: 200, y: 220, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .contained(.secondary5))
         containedButtonSecondary5.styleWith(theme: theme)

         let defaultButton = UIButton(type: .system)
         defaultButton.frame = CGRect(x: 20, y: 270, width: BUTTON_WIDTH, height: BUTTON_HEIGHT)

         return [
             containedButtonPrimary,
             containedButtonSecondary1,
             containedButtonSecondary2,
             containedButtonSecondary3,
             containedButtonSecondary4,
             containedButtonSecondary5,
             defaultButton
         ]
    }
}
