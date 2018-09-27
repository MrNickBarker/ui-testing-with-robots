//  Created by Nikola Lajic on 9/21/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import UIKit

class UITestData {
    struct EnvKeys {
        static let queue = "uit-queue"
        static let volume = "uit-volume"
        static let bass = "uit-bass"
        static let treble = "uit-treble"
    }
    
    static func decodeQueue(_ queueString: String) -> [Song] {
        return queueString.components(separatedBy: ",")
            .compactMap { $0.components(separatedBy: "|") }
            .filter { $0.count == 2 }
            .compactMap { Song(title: $0[0], albumArt: UIImage(named: $0[1])) }
    }
    
    static func encodeQueue(_ queue: [(String,String)]) -> String {
        return queue.map({ "\($0.0)|\($0.1)" }).joined(separator: ",")
    }
    
    static let defaultSongs: [(title: String, albumArt: String)] = [
        ("Song 1", "AlbumA"),
        ("Song 2", "AlbumB"),
        ("Song 3", "AlbumA")
    ]
}
