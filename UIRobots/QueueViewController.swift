//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import UIKit

class QueueViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var player = Player.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension QueueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.queue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "songCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let song = player.queue[indexPath.row]
        let isCurrentlyPlaying = player.isPlaying && player.songIndex == indexPath.row
        
        cell.selectionStyle = .none
        cell.textLabel?.text = song.title
        cell.imageView?.image = song.albumArt
        cell.imageView?.accessibilityLabel = song.albumArt != nil ? song.title : nil
        cell.detailTextLabel?.text = isCurrentlyPlaying ? "Now playing" : nil
        
        return cell
    }
}

extension QueueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousSongIndexPath = IndexPath(row: player.songIndex, section: 0)
        player.songIndex = indexPath.row
        player.isPlaying = true
        tableView.reloadRows(at: [previousSongIndexPath, indexPath], with: .fade)
    }
}

