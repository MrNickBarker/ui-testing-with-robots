//  Created by Nikola Lajic on 9/25/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class QueueTests: BaseTestCase {
    
    func test_givenSongs_showingQueue_showsAllSongs() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            for (i, song) in UITestData.defaultSongs.enumerated() {
                $0.verifySongShown(title: song.title, atIndex: i)
            }
        }
    }
    
    func test_givenPlayingSong_showingQueue_indicatesPlayingSongInQueue() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapSkip()
            $0.tapPlay()
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            for i in 0..<UITestData.defaultSongs.count {
                $0.verifySong(isPlaying: i == 1, atIndex: i)
            }
        }
    }
    
    func test_givenPausedOnAnotherSong_showingQueue_doesntShowAnyPlayingSongs() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapSkip()
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            $0.verifyNoSongsPlaying()
        }
    }
    
    func test_givenPlayingSong_tappingOtherSong_changesPlayingSong() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapPlay()
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            $0.tapSong(atIndex: 2)
            $0.verifySong(isPlaying: false, atIndex: 0)
            $0.verifySong(isPlaying: true, atIndex: 2)
        }
    }
    
    func test_givenNotPlayingAnySong_tappingSong_playsTappedSong() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            $0.tapSong(atIndex: 2)
            $0.verifySong(isPlaying: true, atIndex: 2)
        }
    }
    
    func test_playingSongInQueue_showsSongInPlayer() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            $0.tapSong(atIndex: 2)
        }
        tabBarRobot {
            $0.showPlayer()
        }
        playerRobot {
            $0.verifySongShown(title: UITestData.defaultSongs[2].title)
        }
    }
    
    func test_givenChangingState_switchingBackToQueue_showsUpdatedQueueState() {
        launch {
            $0.queue = UITestData.defaultSongs
        }
        playerRobot {
            $0.tapPlay()
        }
        tabBarRobot {
            $0.showQueue()
            $0.showPlayer()
        }
        playerRobot {
            $0.tapPause()
        }
        tabBarRobot {
            $0.showQueue()
        }
        queueRobot {
            $0.verifyNoSongsPlaying()
        }
    }
}
