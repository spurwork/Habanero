//
//  MenuVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/8/20.
//

import Habanero
import UIKit

// MARK: - MenuVC: StateSwappingVC

class MenuVC: StateSwappingVC {
    
    // MARK: Properties
    
    var example = MenuExample(options: [
        ["Empty", "Red", "Green", "Blue"],
        ["Empty", "Cyan", "Magenta", "Yellow"],
    ], tag: 0)
    
    var menu: Menu!
    var menuButton: Button!
    var rgbView: UIView!
    var cmyView: UIView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Menu"
        
        addAdditionalSubviews()
        
        textField0.isHidden = true
        textField1.isHidden = true
    }
    
    // MARK: Actions
    
    @objc func showPickerTapped() {
        MenuPicker.shared.show(theme: theme,
                               displayable: MenuPickerExample(),
                               delegate: self,
                               presentingVC: self,
                               tag: 1,
                               menu: menu)
    }
    
    // MARK: Helpers
    
    private func addAdditionalSubviews() {
        let colors = theme.colors
        let backgroundColor = colors.backgroundCell
        let borderColor: CGColor = UIColor.black.cgColor
        let borderWidth: CGFloat = 2
        
        let xOffset: CGFloat = 20
        let colorSquareSide: CGFloat = 100
        
        view.backgroundColor = backgroundColor
        
        menuButton = Button(frame: CGRect(x: xOffset,
                                          y: 120,
                                          width: MENU_BUTTON_WIDTH,
                                          height: MENU_BUTTON_HEIGHT),
                            style: .menu)
        menuButton.styleWith(theme: theme)
        menuButton.setTitle("Select item.", for: .normal)
        menuButton.setTitleColor(colors.textButtonMenuPlaceholder, for: .normal)
        menuButton.setTitleColor(colors.textButtonMenuPlaceholder, for: .selected)
        menuButton.setTitleColor(colors.textButtonMenuPlaceholder, for: .highlighted)
        menuButton.isUserInteractionEnabled = false
        view.addSubview(menuButton)
        controls = [menuButton]
        
        menu = Menu(frame: CGRect(x: xOffset, y: 180, width: MENU_BUTTON_WIDTH, height: MENU_BUTTON_HEIGHT),
                    tag: 0,
                    presentingVC: self)
        menu.pickerDelegate = self
        menu.styleWith(theme: theme, displayable: example)
        view.addSubview(menu)
        
        rgbView = UIView(frame: CGRect(x: xOffset,
                                       y: 240,
                                       width: colorSquareSide,
                                       height: colorSquareSide))
        rgbView.backgroundColor = backgroundColor
        rgbView.layer.borderColor = borderColor
        rgbView.layer.borderWidth = borderWidth
        view.addSubview(rgbView)
        
        cmyView = UIView(frame: CGRect(x: (xOffset * 2) + colorSquareSide,
                                       y: 240,
                                       width: colorSquareSide,
                                       height: colorSquareSide))
        cmyView.backgroundColor = backgroundColor
        cmyView.layer.borderColor = borderColor
        cmyView.layer.borderWidth = borderWidth
        view.addSubview(cmyView)
        
        let showPicker = UIButton(type: .system)
        showPicker.frame = CGRect(x: xOffset,
                                  y: view.frame.height - 80,
                                  width: BUTTON_WIDTH,
                                  height: BUTTON_HEIGHT)
        showPicker.contentHorizontalAlignment = .left
        showPicker.addTarget(self, action: #selector(showPickerTapped), for: .touchUpInside)
        showPicker.setTitle(MENU_PICKER_CUSTOM_TITLE, for: .normal)
        view.addSubview(showPicker)
    }
}

// MARK: - MenuVC: MenuPickerDelegate

extension MenuVC: MenuPickerDelegate {
    func menuPickerFinished(pickerView: UIPickerView, selectedIndices: [Int]) {
        guard selectedIndices.count == 2 else { return }
        
        let colors = theme.colors
        
        if pickerView.tag == 0 {
            example = MenuExample(options: example.options,
                                  tag: 0,
                                  selectedIndices: (selectedIndices[0], selectedIndices[1]))
            menu?.styleWith(theme: theme, displayable: example)
            
            switch example.selectedIndices.0 {
            case 0: rgbView.backgroundColor = colors.backgroundCell
            case 1: rgbView.backgroundColor = .red
            case 2: rgbView.backgroundColor = .green
            default: rgbView.backgroundColor = .blue
            }
            
            switch example.selectedIndices.1 {
            case 0: cmyView.backgroundColor = colors.backgroundCell
            case 1: cmyView.backgroundColor = .cyan
            case 2: cmyView.backgroundColor = .magenta
            default: cmyView.backgroundColor = .yellow
            }
        }
    }
}
