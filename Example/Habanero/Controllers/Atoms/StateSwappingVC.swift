//
//  StateSwappingVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/10/20.
//

import Habanero
import UIKit

// MARK: - StateSwappingVC: UIViewController

class StateSwappingVC: UIViewController {
    
    // MARK: Properties
    
    let theme = ThemeStandard()
    
    var visibleState: UIControl.State = .normal
    var stateLabel: UILabel!
    
    var textField0: UITextField!
    var textField1: UITextField!
    
    var controls: [UIControl] = [] {
        didSet {
            for control in controls {
                control.isUserInteractionEnabled = true
            }
        }
    }
    
    var showStateEditingTextFields: Bool = true {
        didSet {
            textField0.isHidden = !showStateEditingTextFields
            textField1.isHidden = !showStateEditingTextFields
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = theme.colors
        view.backgroundColor = colors.backgroundCell
        
        let xOffset: CGFloat = 20
        let halfWidth = (view.frame.width / 2.0) - 40
        let fullWidth = view.frame.width - 40
        stateLabel = UILabel(frame: CGRect(x: xOffset, y: 70, width: fullWidth, height: 44))
        stateLabel.attributedText = "State: Enabled".attributed(fontStyle: .labelLarge, color: colors.textHighEmphasis)
        view.addSubview(stateLabel)
        
        let stateInfoLabel = UILabel(frame: CGRect(x: xOffset,
                                                   y: view.frame.height - (70 + BUTTON_HEIGHT + 10 + BUTTON_HEIGHT + 10 + 80),
                                                   width: fullWidth,
                                                   height: 100))
        stateInfoLabel.numberOfLines = 0        
        stateInfoLabel.attributedText = """
        State: Enabled - control can be tapped
        State: Disabled - control cannot be tapped
        State: Selected/Focused - control has been manually selected or selected by screen reader
        State: Highlighted/Pressed - control is being pressed
        """.attributed(fontStyle: .labelSmall, color: colors.textHighEmphasis)
        view.addSubview(stateInfoLabel)
        
        let changeStateButton = UIButton(type: .system)
        changeStateButton.frame = CGRect(x: xOffset,
                                         y: view.frame.height - (80 + BUTTON_HEIGHT + 10),
                                         width: BUTTON_WIDTH,
                                         height: BUTTON_HEIGHT)
        changeStateButton.contentHorizontalAlignment = .left
        changeStateButton.addTarget(self, action: #selector(changeStateButtonTapped), for: .touchUpInside)
        changeStateButton.setTitle("Change State", for: .normal)
        view.addSubview(changeStateButton)
                
        textField0 = UITextField(frame: CGRect(x: xOffset,
                                               y: view.frame.height - 80,
                                               width: halfWidth,
                                               height: 50))
        textField0.tag = 0
        textField0.delegate = self
        view.addSubview(textField0)
        
        textField1 = UITextField(frame: CGRect(x: xOffset + (view.frame.width / 2.0),
                                               y: view.frame.height - 80,
                                               width: halfWidth,
                                               height: 50))
        textField1.tag = 1
        textField1.delegate = self
        view.addSubview(textField1)
    }
    
    // MARK: Actions
    
    @objc func changeStateButtonTapped() {
        for control in controls {
            switch visibleState {
            case .normal:
                control.isEnabled = false
            case .disabled:
                control.isEnabled = true
                control.isSelected = true
            case .selected:
                control.isSelected = false
                control.isHighlighted = true
            case .highlighted:
                control.isHighlighted = false
            default:
                break
            }
        }
        
        switch visibleState {
        case .normal:
            visibleState = .disabled
            stateLabel.text = "State: Disabled"
        case .disabled:
            visibleState = .selected
            stateLabel.text = "State: Selected/Focused"
        case .selected:
            visibleState = .highlighted
            stateLabel.text = "State: Highlighted/Pressed"
        case .highlighted:
            visibleState = .normal
            stateLabel.text = "State: Enabled"
        default:
            break
        }
    }
    
    open func textFieldHasUpdated(text: String, tag: Int) {}
}

// MARK: - StateSwappingVC: UITextFieldDelegate

extension StateSwappingVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // apply their change to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // update text
        let placeholder = (textField.tag == 0) ? textField0.placeholder : textField1.placeholder
        let nextText = updatedText.isEmpty ? (placeholder ?? "") : updatedText
        textFieldHasUpdated(text: nextText, tag: textField.tag)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

