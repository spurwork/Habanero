//
//  HabaneroExampleFC.swift
//  Habanero
//
//  Created by Jarrod Parkes on 5/12/20.
//

import Habanero
import UIKit

// MARK: - HabaneroExampleFC: BaseFC

class HabaneroExampleFC: BaseFC {

    // MARK: Helpers

    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
