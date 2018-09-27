//  Created by Nikola Lajic on 9/24/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class EqualizerTests: BaseTestCase {
    
    func test_givenDefaultValues_launch_showsDefaultValues() {
        launch {
            $0.volume = 80
            $0.bass = 20
            $0.treble = 30
        }
        tabBarRobot {
            $0.showEqualizer()
        }
        equalizerRobot {
            $0.verifyVolume(is: 80)
            $0.verifyBass(is: 20)
            $0.verifyTreble(is: 30)
        }
    }
    
    func test_changingSliderValues_updatesTextualValues() {
        launch {
            $0.volume = 100
            $0.bass = 100
            $0.treble = 100
        }
        tabBarRobot {
            $0.showEqualizer()
        }
        equalizerRobot {
            $0.setVolume(to: 10)
            $0.verifyVolume(is: 10)
            $0.setBass(to: 70)
            $0.verifyBass(is: 70)
            $0.setTreble(to: 20)
            $0.verifyTreble(is: 20)
        }
    }
    
    func test_changingPlayerVolume_updatesEqualizerVolume() {
        launch {
            $0.volume = 100
        }
        playerRobot {
            $0.setVolume(to: 10)
        }
        tabBarRobot {
            $0.showEqualizer()
        }
        equalizerRobot {
            $0.verifyVolume(is: 10)
        }
    }
}
