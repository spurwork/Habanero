//
//  MainFC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/12/20.
//

import Habanero
import UIKit

// MARK: - MainFC: HabaneroExampleFC

class MainFC: HabaneroExampleFC {
    
    // MARK: Properties
    
    override var rootViewController: UIViewController { return navigationController }
    
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }()
    
    weak var window: UIWindow?
    
    // MARK: Initializer
    
    init(window: UIWindow, theme: Theme) {
        self.window = window
        
        super.init(theme: theme)
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    // MARK: Start
    
    override func start() {
        let habaneroVC = ActionListVC(theme: theme,
                                             title: "Habanero",
                                             items: [
                                                "Typographic Scale",
                                                "Icons",
                                                "Colors",
                                                "Atoms",
                                                "Components",
                                                "Transitions",
                                                "Screens"])
        habaneroVC.delegate = self
        
        navigationController.setViewControllers([habaneroVC], animated: true)
    }
    
    // MARK: Helpers (Subflows)
    
    func startAtomsFC() {
        let atomsFC = AtomsFC(theme: theme)
        atomsFC.delegate = self
        atomsFC.start()
        
        addChildFC(atomsFC)
        rootViewController.present(atomsFC.rootViewController, animated: true)
    }
    
    func startComponentsFC() {
        let componentsFC = ComponentsFC(theme: theme)
        componentsFC.delegate = self
        componentsFC.start()
        
        addChildFC(componentsFC)
        rootViewController.present(componentsFC.rootViewController, animated: true)
    }
    
    // MARK: Helpers
    
    func startTypographyVC() {
        let fontStyles: [FontStyle] = [
            .h1,
            .h2,
            .h3,
            .h4,
            .h5,
            .h6,
            .buttonText,
            .labelLarge,
            .labelSmall,
            .bodyLarge,
            .bodySmall]
        
        let typographyVC = TypographyVC(fontStyles: fontStyles)
        navigationController.pushViewController(typographyVC, animated: true)
    }
    
    func startIconsVC() {
        let images = theme.images
        
        let icons = [
            Icon(name: "Add", image: images.add),
            Icon(name: "Bell", image: images.bell),
            Icon(name: "Briefcase", image: images.briefcase),
            Icon(name: "Camera", image: images.camera),
            Icon(name: "CaretDown", image: images.caretDown),
            Icon(name: "CaretLeft", image: images.caretLeft),
            Icon(name: "CaretLeftThick", image: images.caretLeftThick),
            Icon(name: "CaretRight", image: images.caretRight),
            Icon(name: "CaretRightThick", image: images.caretRightThick),
            Icon(name: "CaretUp", image: images.caretUp),
            Icon(name: "CheckCircle", image: images.checkCircle),
            Icon(name: "CheckSmall", image: images.checkSmall),
            Icon(name: "Clipboard", image: images.clipboard),
            Icon(name: "Close", image: images.close),
            Icon(name: "CloseCircle", image: images.closeCircle),
            Icon(name: "Edit", image: images.edit),
            Icon(name: "Email", image: images.email),
            Icon(name: "Error", image: images.error),
            Icon(name: "FaceSmile", image: images.faceSmile),
            Icon(name: "Folder", image: images.folder),
            Icon(name: "Gear", image: images.gear),
            Icon(name: "HeartPlus", image: images.heartPlus),
            Icon(name: "Help", image: images.help),
            Icon(name: "Info", image: images.info),
            Icon(name: "LightBulb", image: images.lightBulb),
            Icon(name: "Lock", image: images.lock),
            Icon(name: "Logout", image: images.logout),
            Icon(name: "Menu", image: images.menu),
            Icon(name: "Money", image: images.money),
            Icon(name: "Notes", image: images.notes),
            Icon(name: "Parking", image: images.parking),
            Icon(name: "PhoneCall", image: images.phoneCall),
            Icon(name: "Profile", image: images.profile),
            Icon(name: "Search", image: images.search),
            Icon(name: "Ticket", image: images.ticket),
            Icon(name: "TimeClock", image: images.timeClock),
            Icon(name: "Uniform", image: images.uniform),
            Icon(name: "User", image: images.user),
            Icon(name: "Warning", image: images.warning)
        ]
        
        let iconsVC = ActionListVC(theme: theme, title: "Icons", items: icons)
        navigationController.pushViewController(iconsVC, animated: true)
    }
    
    func startColorsVC() {
        let colors = [
            Color(category: .surface, name: "Black", color: .surfaceBlack, textColor: .white),
            Color(category: .textOnSurface, name: "High Emphasis", color: .white, textColor: .textHighEmphasis),
            Color(category: .textOnSurface, name: "Medium Emphasis", color: .white, textColor: .textMediumEmphasis),
            Color(category: .textOnSurface, name: "Disabled", color: .white, textColor: .textDisabled),
            Color(category: .primary, name: "Gold", color: .primaryGold, textColor: .white),
            Color(category: .primary, name: "Beige", color: .primaryBeige, textColor: .textHighEmphasis),
            Color(category: .primary, name: "Beige 2", color: .primaryBeige2, textColor: .textHighEmphasis),
            Color(category: .supportive, name: "Black 400", color: .supportBlack400, textColor: .white),
            Color(category: .supportive, name: "Black 300", color: .supportBlack300, textColor: .white),
            Color(category: .supportive, name: "Black 200", color: .supportBlack200, textColor: .white),
            Color(category: .supportive, name: "Black 100", color: .supportBlack100, textColor: .white),
            Color(category: .supportive, name: "Grey 400", color: .supportGrey400, textColor: .white),
            Color(category: .secondary, name: "Blue", color: .secondaryBlue, textColor: .textHighEmphasis),
            Color(category: .secondary, name: "Green", color: .secondaryGreen, textColor: .textHighEmphasis),
            Color(category: .secondary, name: "Orange", color: .secondaryOrange, textColor: .textHighEmphasis),
            Color(category: .secondary, name: "Pink", color: .secondaryPink, textColor: .textHighEmphasis),
            Color(category: .secondary, name: "Purple", color: .secondaryPurple, textColor: .white),
            Color(category: .supportive, name: "State Blue", color: .stateBlue, textColor: .white),
            Color(category: .supportive, name: "State Green", color: .stateGreen, textColor: .white),
            Color(category: .supportive, name: "State Yellow", color: .stateYellow, textColor: .textHighEmphasis),
            Color(category: .supportive, name: "Error Red", color: .errorRed, textColor: .white),
            Color(category: .supportive, name: "Error Red Hover", color: .errorRedHover, textColor: .white),
            Color(category: .supportive, name: "Error Red Pressed", color: .errorRedPressed, textColor: .white)
        ]
        
        let colorsVC = ColorsVC(colors: colors)
        navigationController.pushViewController(colorsVC, animated: true)
    }
}

// MARK: - MainFC: ActionListVCDelegate

extension MainFC: ActionListVCDelegate {
    func actionListVCTappedDismiss(_ actionListVC: ActionListVC) {}
    
    func actionListVCTappedRow(_ actionListVC: ActionListVC, row: Int) {
        switch row {
        case 0: startTypographyVC()
        case 1: startIconsVC()
        case 2: startColorsVC()
        case 3: startAtomsFC()
        case 4: startComponentsFC()
        default: displayAlert(title: "Not Implemented", message: "TBD. Ask Jarrod.")
        }
    }
}

// MARK: - MainFC: AtomsFCDelegate

extension MainFC: AtomsFCDelegate {
    func atomsFCShouldDismiss(_ atomsFC: AtomsFC) {
        removeChildFC(atomsFC)
        rootViewController.dismiss(animated: true)
    }
}

// MARK: - MainFC: ComponentsFCDelegate

extension MainFC: ComponentsFCDelegate {
    func componentsFCShouldDismiss(_ componentsFC: ComponentsFC) {
        removeChildFC(componentsFC)
        rootViewController.dismiss(animated: true)
    }
}
