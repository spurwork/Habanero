//
//  AppDelegate.swift
//  Habanero
//
//  Created by Jarrod Parkes on 05/06/2020.
//

import Habanero
import UIKit

// MARK: - AppDelegate: UIResponder, UIApplicationDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties

    var window: UIWindow?
    var mainFC: MainFC?

    // MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // load fonts
        ThemeStandard.loadFonts()

        // create main window
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }

        // start initial flow
        mainFC = MainFC(window: window, theme: ThemeStandard())
        mainFC?.start()

        return true
    }
}
