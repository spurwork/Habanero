//
//  ButtonsBarVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/8/20.
//

import Habanero
import UIKit

// MARK: - ButtonsBarVC: UIViewController

class ButtonsBarVC: UIViewController {

    // MARK: Properties

    let theme = ThemeStandard()
    
    var count = 1
    var showBadge = true
    var badgeButton: UIBarButtonItem!

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = ""
        
        let colors = theme.colors
        let images = theme.images
        view.backgroundColor = colors.backgroundCell
        
        // left
        navigationItem.leftBarButtonItem = UIBarButtonItem.createLabelItem(theme: theme,
                                                                           text: "Bar Button")

        // right
        badgeButton = UIBarButtonItem.createImageButtonItem(theme: theme,
                                                            image: images.bell,
                                                            target: self,
                                                            action: #selector(toggleBadge),
                                                            accessibilityIdentifier: "badge-button")
        badgeButton.addBadge(theme: theme, number: count)
                
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem.createImageButtonItem(theme: theme,
                                                  image: images.logout,
                                                  target: self,
                                                  action: #selector(backButtonTapped),
                                                  accessibilityIdentifier: "back-button"),
            badgeButton
        ]
    }
    
    // MARK: Actions
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)        
    }
    
    @objc func toggleBadge() {
        showBadge = !showBadge
        
        if showBadge {
            count = (count == 10) ? 1 : (count + 1)
            badgeButton.addBadge(theme: theme, number: count)
        } else {
            badgeButton.removeBadge()
        }
    }
}
