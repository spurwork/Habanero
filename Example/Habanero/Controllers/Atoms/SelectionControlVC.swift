//
//  SelectionControlVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/10/20.
//

import Habanero
import UIKit

// MARK: - SelectionControlVC: StateSwappingVC

class SelectionControlVC: StateSwappingVC {
    
    // MARK: Properties
    
    let type: SelectionControlType
    
    var examples: [SelectionControlExample] = [
        SelectionControlExample(title: SELECTION_CONTROL_TITLE, tip: nil, tipLinkable: false, isSelected: false, isEnabled: true),
        SelectionControlExample(title: SELECTION_CONTROL_TITLE, tip: SELECTION_CONTROL_TIP, tipLinkable: false, isSelected: false, isEnabled: true),
        SelectionControlExample(title: SELECTION_CONTROL_TITLE, tip: SELECTION_CONTROL_TIP, tipLinkable: true, isSelected: false, isEnabled: true)
    ]
    
    // MARK: Initializer
    
    init(type: SelectionControlType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
        
        title = (type == .radio) ? "Radio Buttons" : "Checkboxes"
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controls = getControls()
        
        textField0.placeholder = SELECTION_CONTROL_TITLE
        textField1.placeholder = SELECTION_CONTROL_TIP
    }
    
    // MARK: Helpers
    
    func getControls() -> [UIControl] {
        let xOffset: CGFloat = 20
        
        let control0 = SelectionControl(frame: CGRect(x: xOffset,
                                                      y: 130,
                                                      width: view.frame.width - 40,
                                                      height: SELECTION_CONTROL_HEIGHT),
                                        type: type)
        control0.delegate = self
        control0.setControlTag(0)
        control0.styleWith(theme: theme, displayable: examples[0])
        view.addSubview(control0)
        
        let control1 = SelectionControl(frame: CGRect(x: xOffset,
                                                      y: 200,
                                                      width: view.frame.width - 40,
                                                      height: SELECTION_CONTROL_HEIGHT),
                                        type: type)
        control1.delegate = self
        control1.setControlTag(1)
        control1.styleWith(theme: theme, displayable: examples[1])
        view.addSubview(control1)
        
        let control2 = SelectionControl(frame: CGRect(x: xOffset,
                                                      y: 270,
                                                      width: view.frame.width - 40,
                                                      height: SELECTION_CONTROL_HEIGHT),
                                        type: type)
        control2.delegate = self
        control2.tipDelegate = self
        control2.setControlTag(2)
        control2.styleWith(theme: theme, displayable: examples[2])
        view.addSubview(control2)
        
        return [
            control0,
            control1,
            control2
        ]
    }
    
    func printControls() {
        let message = "There are \(controls.count) selection controls on this screen."
        let alert = Alert(type: .error, message: message, duration: 2.0, anchor: .center)
        
        AlertManager.shared.show(alert, onView: view, withTheme: theme, completionHandler: {
            print("Alert finshed!")
        })
    }
    
    override func textFieldHasUpdated(text: String, tag: Int) {
        for index in 0..<examples.count {
            switch tag {
            case 0:
                examples[index] = SelectionControlExample(title: text,
                                                          tip: examples[index].tip,
                                                          tipLinkable: examples[index].tipLinkable,
                                                          isSelected: examples[index].isSelected,
                                                          isEnabled: examples[index].isEnabled)
            default:
                if examples[index].tip != nil {
                    examples[index] = SelectionControlExample(title: examples[index].title,
                                                              tip: text,
                                                              tipLinkable: examples[index].tipLinkable,
                                                              isSelected: examples[index].isSelected,
                                                              isEnabled: examples[index].isEnabled)
                }
            }
        }
        for index in 0..<controls.count {
            if let selectionControl = controls[index] as? SelectionControl {
                selectionControl.styleWith(theme: theme, displayable: examples[index])
            }            
        }
    }
}

// MARK: - SelectionControlVC: SelectionControlDelegate

extension SelectionControlVC: SelectionControlDelegate {
    func selectionControlWasTapped(_ selectionControl: SelectionControl) {
        selectionControl.toggle()
    }
}

// MARK: - SelectionControlVC: SelectionControlTipDelegate

extension SelectionControlVC: SelectionControlTipDelegate {
    func selectionControlTipWasTapped(_ selectionControl: SelectionControl) {
        printControls()
    }
}
