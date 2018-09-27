//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

class TabBarRobot {
    let app = XCUIApplication()
}

// MARK: - Actions
extension TabBarRobot {
    func showEqualizer() {
        app.tabBars.buttons["Equalizer"].tap()
    }
    
    func showPlayer() {
        app.tabBars.buttons["Player"].tap()
    }
    
    func showQueue() {
        app.tabBars.buttons["Queue"].tap()
    }
}

// MARK: - Assertions
extension TabBarRobot {
    func verifyOnPlayerTab(_ file: StaticString = #file, _ line: UInt = #line) {
        XCTAssertTrue(app.tabBars.buttons["Player"].isSelected, "Not on player tab", file: file, line: line)
    } 
}
