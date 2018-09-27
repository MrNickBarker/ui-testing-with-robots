//  Created by Nikola Lajic on 9/18/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import UIKit

class Player {
    static let sharedInstance = Player()
    var volume: Int = 100
    var bass: Int = 50
    var treble: Int = 50
    var songIndex = 0
    var isPlaying: Bool = false
    var queue: [Song] = [Song(title: "First song", albumArt: #imageLiteral(resourceName: "AlbumB")), Song(title: "Second song", albumArt: #imageLiteral(resourceName: "AlbumA"))] {
        didSet {
            songIndex = 0
        }
    }
    
    private init() {}
    
    func canGoBack() -> Bool {
        return songIndex > 0 && queue.count > 1
    }
    
    func canSkip() -> Bool {
        return songIndex < queue.count - 1
    }
    
    func currentSong() -> Song? {
        return songIndex < queue.count ? queue[songIndex] : nil
    }
    
    func skip() {
        guard canSkip() else { return }
        songIndex += 1
    }
    
    func goBack() {
        guard canGoBack() else { return }
        songIndex -= 1
    }
}
