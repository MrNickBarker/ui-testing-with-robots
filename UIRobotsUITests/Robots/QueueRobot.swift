//  Created by Nikola Lajic on 9/25/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class QueueRobot {
    let app = XCUIApplication()
}

// MARK: - Actions
extension QueueRobot {
    func tapSong(atIndex index: Int) {
        app.cells.element(boundBy: index).tap()
    }
}

// MARK: - Assertions
extension QueueRobot {
    func verifySongShown(title: String, atIndex index: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(app.cells.element(boundBy: index).staticTexts[title].exists, "Title not shown: \(title)", file: file, line: line)
        XCTAssertTrue(app.cells.element(boundBy: index).images[title].exists, "Image not shown: \(title)", file: file, line: line)
    }
    
    func verifySong(isPlaying playing: Bool, atIndex index: Int, file: StaticString = #file, line: UInt = #line) {
        let message = "Song is\(playing ? " not" : "") playing at index: \(index)"
        XCTAssertEqual(app.cells.element(boundBy: index).staticTexts["Now playing"].exists, playing, message, file: file, line: line)
    }
    
    func verifyNoSongsPlaying(file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(app.cells.staticTexts["Now playing"].exists, "A song is shown to be playing", file: file, line: line)
    }
}
