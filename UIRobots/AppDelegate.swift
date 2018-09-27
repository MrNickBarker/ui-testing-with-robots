//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupUITestData()
        if let tabBar = window?.rootViewController as? UITabBarController {
            tabBar.selectedIndex = 1
        }
        return true
    }
}

extension AppDelegate {
    func setupUITestData() {
        guard ProcessInfo().arguments.contains("--uitesting") else { return }
        
        let env = ProcessInfo().environment
        let player = Player.sharedInstance
        
        if let queueString = env[UITestData.EnvKeys.queue] {
            player.queue = UITestData.decodeQueue(queueString)
        }
        if let volumeString = env[UITestData.EnvKeys.volume], let volume = Int(volumeString) {
            player.volume = volume
        }
        if let bassString = env[UITestData.EnvKeys.bass], let bass = Int(bassString) {
            player.bass = bass
        }
        if let trebleString = env[UITestData.EnvKeys.treble], let treble = Int(trebleString) {
            player.treble = treble
        }
    }
}

