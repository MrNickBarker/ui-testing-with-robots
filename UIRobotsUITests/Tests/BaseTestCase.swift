//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class BaseTestCase: XCTestCase {
    // If your robots are statefull they need to be recreated for each test
    private let tabBarRobot = TabBarRobot()
    private let playerRobot = PlayerRobot()
    private let equalizerRobot = EqualizerRobot()
    private let queueRobot = QueueRobot()
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }
}

extension BaseTestCase {
    func tabBarRobot(_ steps: (TabBarRobot) -> Void) {
        steps(tabBarRobot)
    }
    
    func playerRobot(_ steps: (PlayerRobot) -> Void) {
        steps(playerRobot)
    }
    
    func equalizerRobot(_ steps: (EqualizerRobot) -> Void) {
        steps(equalizerRobot)
    }
    
    func queueRobot(_ steps: (QueueRobot) -> Void) {
        steps(queueRobot)
    }
    
    func launch(_ setup: ((LaunchArguments) -> Void)? = nil) {
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        
        let arguments = LaunchArguments()
        setup?(arguments)
        app.launchEnvironment[UITestData.EnvKeys.queue] = UITestData.encodeQueue(arguments.queue)
        if let volume = arguments.volume {
            app.launchEnvironment[UITestData.EnvKeys.volume] = "\(volume)"
        }
        if let bass = arguments.bass {
            app.launchEnvironment[UITestData.EnvKeys.bass] = "\(bass)"
        }
        if let treble = arguments.treble {
            app.launchEnvironment[UITestData.EnvKeys.treble] = "\(treble)"
        }
        
        app.launch()
    }
}

class LaunchArguments {
    var queue: [(title: String, albumArt: String)] = []
    var volume: Int?
    var bass: Int?
    var treble: Int?
}
