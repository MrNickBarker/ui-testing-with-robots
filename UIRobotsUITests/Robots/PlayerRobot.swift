//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class PlayerRobot {
    let app = XCUIApplication()
    lazy var volumeSlider = app.sliders["Volume Slider"]
    lazy var volumeLabel = app.staticTexts["Volume Label"]
}

// MARK: - Actions
extension PlayerRobot {
    func setVolume(to volume: CGFloat) {
        volumeSlider.jiggle(toNormalizedSliderPosition: volume / 100.0)
    }
    
    func tapPlay() {
        app.buttons["▶️"].tap()
    }
    
    func tapPause() {
        app.buttons["⏸"].tap()
    }
    
    func tapSkip(count: Int = 1) {
        for _ in 0..<count { app.buttons["⏩"].tap() }
    }
    
    func tapGoBack() {
        app.buttons["⏪"].tap()
    }
}

// MARK: - Assertions
extension PlayerRobot {
    func verifyVolume(is volume: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(volumeLabel.label, "\(volume)%", "Wrong volume text", file: file, line: line)
        XCTAssertEqual(volumeSlider.normalizedSliderPosition, CGFloat(volume) / 100.0, accuracy: 0.1, file: file, line: line)
    }
    
    func verifyPlayButton(visible: Bool, file: StaticString = #file, line: UInt = #line) {
        verifyButton("▶️", visible: visible, file: file, line: line)
    }
    
    func verifyPauseButton(visible: Bool, file: StaticString = #file, line: UInt = #line) {
        verifyButton("⏸", visible: visible, file: file, line: line)
    }
    
    func verifySkip(visible: Bool, file: StaticString = #file, line: UInt = #line) {
        verifyButton("⏩", visible: visible, file: file, line: line)
    }
 
    func verifyGoBack(visible: Bool, file: StaticString = #file, line: UInt = #line) {
        verifyButton("⏪", visible: visible, file: file, line: line)
    }
    
    func verifySongShown(title: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(app.staticTexts["Song Title"].label, title, "Song name not shown: \(title)", file: file, line: line)
        XCTAssertEqual(app.images["Album Art"].label, "Album art: \(title)", "Album art not shown: \(title)", file: file, line: line)
    }
}

private extension PlayerRobot {
    func verifyButton(_ title: String, visible: Bool, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(app.buttons[title].exists, visible, "\(title) button \(visible ? "not" : "") visible", file: file, line: line)
    }
}
