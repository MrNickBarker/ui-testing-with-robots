//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class PlayerTests: BaseTestCase {
    
    func test_givenDefaultVolume_launch_showsDefaultVolume() {
        launch {
            $0.volume = 50
        }
        playerRobot {
            $0.verifyVolume(is: 50)
        }
    }
    
    func test_launch_showsPlayer() {
        launch()
        tabBarRobot {
            $0.verifyOnPlayerTab()
        }
    }
    
    func test_slidingVolume_updatesVolumeText() {
        launch {
            $0.volume = 50
        }
        playerRobot {
            $0.verifyVolume(is: 50)
            $0.setVolume(to: 0)
            $0.verifyVolume(is: 0)
            $0.setVolume(to: 100)
            $0.verifyVolume(is: 100)
        }
    }
    
    func test_adjustingVolumeOnEqualizer_updatesVolumeOnPlayer() {
        launch {
            $0.volume = 0
        }
        playerRobot {
            $0.verifyVolume(is: 0)
        }
        tabBarRobot {
            $0.showEqualizer()
        }
        equalizerRobot {
            $0.setVolume(to: 100)
        }
        tabBarRobot {
            $0.showPlayer()
        }
        playerRobot {
            $0.verifyVolume(is: 100)
        }
    }
    
    func test_givenNoSongs_launch_hidesSkipAndGoBackButtons() {
        launch()
        playerRobot {
            $0.verifyPlayButton(visible: true)
            $0.verifyPauseButton(visible: false)
            $0.verifyGoBack(visible: false)
            $0.verifySkip(visible: false)
        }
    }
    
    func test_givenOneSong_launch_hidesSkipAndGoBackButtons() {
        launch {
            $0.queue = [("Song 1", "")]
        }
        playerRobot {
            $0.verifyPlayButton(visible: true)
            $0.verifyPauseButton(visible: false)
            $0.verifyGoBack(visible: false)
            $0.verifySkip(visible: false)
        }
    }
    
    func test_givenSongs_launch_showsSkipButton() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.verifyPlayButton(visible: true)
            $0.verifyPauseButton(visible: false)
            $0.verifyGoBack(visible: false)
            $0.verifySkip(visible: true)
        }
    }
    
    func test_givenSongs_pressingPlay_showsPauseButton() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapPlay()
            $0.verifyPlayButton(visible: false)
            $0.verifyPauseButton(visible: true)
        }
    }
    
    func test_givenPlayingSong_pausing_showsPlayButton() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapPlay()
            $0.tapPause()
            $0.verifyPlayButton(visible: true)
            $0.verifyPauseButton(visible: false)
        }
    }
    
    func test_givenSongs_launch_showsFirstSong() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.verifySongShown(title: UITestData.defaultSongs[0].title)
        }
    }
    
    func test_givenSongs_returningToFirstSong_hidesGoBackButton() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.verifyGoBack(visible: false)
            $0.tapSkip()
            $0.verifyGoBack(visible: true)
            $0.tapGoBack()
            $0.verifyGoBack(visible: false)
        }
    }
    
    func test_givenSongs_changingSongs_showsCurrentSong() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapSkip()
            $0.verifySongShown(title: UITestData.defaultSongs[1].title)
            $0.tapGoBack()
            $0.verifySongShown(title: UITestData.defaultSongs[0].title)
        }
    }
    
    func test_givenSongs_skippingToEnd_hidesSkipButton() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapSkip(count: UITestData.defaultSongs.count - 1)
            $0.verifySkip(visible: false)
        }
    }
}
