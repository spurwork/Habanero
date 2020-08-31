//
//  BaseFC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 6/1/20.
//

import Habanero
import UIKit

// MARK: - FlowCoordinator

protocol FlowCoordinator: class {
    var theme: Theme { get set }
    var rootViewController: UIViewController { get }
    var lastModalPresentedByViewController: UIViewController? { get }
    var childFCs: [FlowCoordinator] { get set }

    func start()
}

// MARK: - FlowCoordinator (Helpers)

extension FlowCoordinator {
    func addChildFC(_ childFC: FlowCoordinator) {
        childFCs.append(childFC)
    }

    func removeChildFC(_ childFC: FlowCoordinator) {
        childFCs = childFCs.filter { $0 !== childFC }
    }
}

// MARK: - BaseFC

typealias BaseFC = BaseFCImplementation & FlowCoordinator

// MARK: - BaseFCImplementation: NSObject

class BaseFCImplementation: NSObject {

    // MARK: Properties

    var theme: Theme
    var childFCs: [FlowCoordinator] = []
    var rootViewController: UIViewController { return UINavigationController() }
    var lastModalPresentedByViewController: UIViewController?

    // MARK: Initializer

    init(theme: Theme) {
        self.theme = theme
    }

    // MARK: FlowCoordinator

    func start() {}
}
