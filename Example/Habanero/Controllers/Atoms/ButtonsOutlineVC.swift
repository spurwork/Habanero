//
//  ButtonsOutlineVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/1/20.
//

import Habanero
import UIKit

// MARK: - ButtonsOutlineVC: ButtonsVC

class ButtonsOutlineVC: ButtonsVC {

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Outline Button"
    }
    
    // MARK: ButtonsVC
    
    override func getExampleButtons() -> [UIButton] {
         let outlineButtonPrimary = Button(frame: CGRect(x: 20, y: 120, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.primary))
         outlineButtonPrimary.styleWith(theme: theme)

         let outlineButtonSecondary0 = Button(frame: CGRect(x: 20, y: 170, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.secondary0))
         outlineButtonSecondary0.styleWith(theme: theme)
         
         let outlineButtonSecondary1 = Button(frame: CGRect(x: 200, y: 170, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.secondary1))
         outlineButtonSecondary1.styleWith(theme: theme)

         let outlineButtonSecondary2 = Button(frame: CGRect(x: 20, y: 220, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.secondary2))
         outlineButtonSecondary2.styleWith(theme: theme)

         let outlineButtonSecondary3 = Button(frame: CGRect(x: 200, y: 220, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.secondary3))
         outlineButtonSecondary3.styleWith(theme: theme)

         let outlineButtonSecondary4 = Button(frame: CGRect(x: 20, y: 270, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.secondary4))
         outlineButtonSecondary4.styleWith(theme: theme)

         let outlineButtonSecondary5 = Button(frame: CGRect(x: 200, y: 270, width: BUTTON_WIDTH, height: BUTTON_HEIGHT), style: .outline(.secondary5))
         outlineButtonSecondary5.styleWith(theme: theme)

         let defaultButton = UIButton(type: .system)
         defaultButton.frame = CGRect(x: 20, y: 320, width: BUTTON_WIDTH, height: BUTTON_HEIGHT)

         return [
             outlineButtonPrimary,
             outlineButtonSecondary0,
             outlineButtonSecondary1,
             outlineButtonSecondary2,
             outlineButtonSecondary3,
             outlineButtonSecondary4,
             outlineButtonSecondary5,
             defaultButton
         ]
    }
}
