//
//  TextInputVC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 7/9/20.
//

import Habanero
import JValidator

// MARK: - TextInputVC: StateSwappingVC

class TextInputVC: StateSwappingVC {
    
    // MARK: Properties
    
    var examples: [TextInputExample] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Text Inputs"
        
        examples = TextInputExample.mock(theme: theme)
        
        controls = getTextInputs()
        showStateEditingTextFields = false
        
        textField0.isHidden = true
        textField1.isHidden = true
    }
    
    // MARK: Helpers
    
    private func getTextInputs() -> [TextInput] {
        let textInput0 = TextInput(frame: CGRect(x: 10,
                                                 y: 110,
                                                 width: view.frame.width - 20,
                                                 height: 150))
        textInput0.tag = 0
        textInput0.delegate = self
        textInput0.styleWith(theme: theme, displayable: examples[0])
        view.addSubview(textInput0)
        
        let textInput1 = TextInput(frame: CGRect(x: 10,
                                                 y: 220,
                                                 width: view.frame.width - 20,
                                                 height: 225))
        textInput1.tag = 1
        textInput1.delegate = self
        textInput1.styleWith(theme: theme, displayable: examples[1])
        view.addSubview(textInput1)
        
        return [
            textInput0,
            textInput1
        ]
    }
}

// MARK: - TextInputVC: TextInputDelegate

extension TextInputVC: TextInputDelegate {
    func textInputShouldBeginEditing(_ textInput: TextInput) -> Bool {
        return true
    }
    
    func textInputShouldReturn(_ textInput: TextInput) -> Bool {
        return true
    }
    
    func textInputTextDidChange(_ textInput: TextInput, text: String) {
        let tag = textInput.tag
        
        examples[tag].value = text
        
        if let error = Validator.shared.validateString(examples[tag].value,
                                                       withRules:  examples[tag].rules) {
            examples[tag].error = error
        } else {
            examples[tag].error = nil
        }
        
        (controls[tag] as? TextInput)?.styleWith(theme: theme, displayable: examples[tag])
    }
    
    func textInputHasInputError(_ textInput: TextInput, error: Error) {
        textInput.shake()
    }
    
    func showTip(withText text: String, presentedFrom: UIView?) {
        let tip = Tip(message: text)
        AlertManager.shared.show(tip, onView: view,
                                 presentedFrom: presentedFrom,
                                 withTheme: theme)
    }
}
