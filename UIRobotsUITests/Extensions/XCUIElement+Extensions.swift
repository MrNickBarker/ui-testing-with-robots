//  Created by Nikola Lajic on 9/24/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import XCTest

extension XCUIElement {
    /// `adjust(toNormalizedSliderPosition:)` is not reliable, so we "jiggle" until we hit the desired value.
    ///
    /// - Parameters:
    ///   - targetPosition: Normalized value 0.0-1.0.
    ///   - tolerance: Acceptable difference from `targetPosition`.
    ///   - maxRetries: Insurance so test doesn't run indefinetly.
    func jiggle(toNormalizedSliderPosition targetPosition: CGFloat, tolerance: CGFloat = 0.005, maxRetries: Int = 20) {
        var retries = 0
        while abs(normalizedSliderPosition.distance(to: targetPosition)) > tolerance && retries < maxRetries {
            adjust(toNormalizedSliderPosition: targetPosition)
            if normalizedSliderPosition > targetPosition + tolerance {
                adjust(toNormalizedSliderPosition: max(0, targetPosition - CGFloat.random(in: 0.01..<0.1)))
            }
            if normalizedSliderPosition < targetPosition - tolerance {
                adjust(toNormalizedSliderPosition: min(1, targetPosition + CGFloat.random(in: 0.01..<0.1)))
            }
            retries += 1
        }
    }
}
