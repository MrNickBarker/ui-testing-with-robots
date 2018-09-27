//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class EqualizerRobot {
    let app = XCUIApplication()
    lazy var volumeSlider = app.sliders["Volume Slider"]
    lazy var bassSlider = app.sliders["Bass Slider"]
    lazy var trebleSlider = app.sliders["Treble Slider"]
}

// MARK: - Actions
extension EqualizerRobot {
    func setVolume(to value: CGFloat) {
        volumeSlider.jiggle(toNormalizedSliderPosition: value / 100.0)
    }
    
    func setBass(to value: CGFloat) {
        bassSlider.jiggle(toNormalizedSliderPosition: value / 100.0)
    }
    
    func setTreble(to value: CGFloat) {
        trebleSlider.jiggle(toNormalizedSliderPosition: value / 100.0)
    }
}

// MARK: - Assertions
extension EqualizerRobot {
    func verifyVolume(is value: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(app.staticTexts["Volume: \(value)%"].exists, file: file, line: line)
        XCTAssertEqual(volumeSlider.normalizedSliderPosition, CGFloat(value) / 100.0, accuracy: 0.1, file: file, line: line)
    }
    
    func verifyBass(is value: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(app.staticTexts["Bass: \(value)%"].exists, file: file, line: line)
        XCTAssertEqual(bassSlider.normalizedSliderPosition, CGFloat(value) / 100.0, accuracy: 0.1, file: file, line: line)
    }
    
    func verifyTreble(is value: Int, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(app.staticTexts["Treble: \(value)%"].exists, file: file, line: line)
        XCTAssertEqual(trebleSlider.normalizedSliderPosition, CGFloat(value) / 100.0, accuracy: 0.1, file: file, line: line)
    }
}
