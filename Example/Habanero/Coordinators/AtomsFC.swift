//
//  AtomsFC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/12/20.
//

import Habanero
import UIKit

// MARK: - AtomsFCDelegate

protocol AtomsFCDelegate: AnyObject {
    func atomsFCShouldDismiss(_ atomsFC: AtomsFC)
}

// MARK: - AtomsFC: HabaneroExampleFC

class AtomsFC: HabaneroExampleFC {
    
    // MARK: Properties
    
    override var rootViewController: UIViewController { return navigationController }
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }()
    
    weak var delegate: AtomsFCDelegate?
    
    // MARK: Start
    
    override func start() {
        let atomsVC = ActionListVC(theme: theme,
                                          title: "Atoms",
                                          items: [
                                            "Contained Button (Interactive)",
                                            "Outline Button (Interactive)",
                                            "Text Button (Interactive)",
                                            "Button (Styles)",
                                            "Bar Button",
                                            "Checkbox Button",
                                            "Radio Button",
                                            "Menu",
                                            "Text Input (Styles)",
                                            "Text Input (Interactive)",
                                            "Status View (Styles)",
                                            "Alerts (Styles)"],
                                          forceBackable: true)
        atomsVC.delegate = self
        
        navigationController.setViewControllers([atomsVC], animated: true)
    }
}

// MARK: - AtomsFC: ActionListVCDelegate

extension AtomsFC: ActionListVCDelegate {
    func actionListVCTappedDismiss(_ actionListVC: ActionListVC) {
        delegate?.atomsFCShouldDismiss(self)
    }
    
    func actionListVCTappedRow(_ actionListVC: ActionListVC, row: Int) {
        let controller: UIViewController?
        
        switch row {
        case 0: controller = ButtonsContainedVC()
        case 1: controller = ButtonsOutlineVC()
        case 2: controller = ButtonsTextVC()
        case 3: controller = ExamplesVC.buttons(theme: theme)
        case 4: controller = ButtonsBarVC()
        case 5: controller = SelectionControlVC(type: .checkbox)
        case 6: controller = SelectionControlVC(type: .radio)
        case 7: controller = MenuVC()
        case 8: controller = ExamplesVC.textInputs(theme: theme)
        case 9: controller = TextInputVC()
        case 10: controller = ExamplesVC.statusViews(theme: theme)
        case 11: controller = ExamplesVC.alerts(theme: theme)
        default: controller = nil
        }
        
        if let controller = controller {
            navigationController.pushViewController(controller, animated: true)
        } else {
            displayAlert(title: "Not Implemented", message: "TBD. Ask Jarrod.")
        }
    }
}
