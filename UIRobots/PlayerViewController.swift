//  Created by Nikola Lajic on 9/17/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import UIKit

class PlayerViewController: UIViewController {
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumArt: UIImageView!
    var player = Player.sharedInstance
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateControls()
    }
    
    private func updateControls() {
        volumeLabel.text = "\(player.volume)%"
        volumeSlider.value = Float(player.volume)
        previousButton.isEnabled = player.canGoBack()
        skipButton.isEnabled = player.canSkip()
        playButton.isSelected = player.isPlaying
        if let song = player.currentSong() {
            titleLabel.text = song.title
            albumArt.image = song.albumArt
            albumArt.accessibilityLabel = "Album art: \(song.title)"
        }
        else {
            titleLabel.text = "No songs"
            albumArt.image = nil
            albumArt.accessibilityLabel = nil
        }
    }
}

extension PlayerViewController {
    @IBAction func volumeSliderValueChanged(slider: UISlider) {
        player.volume = Int(round(slider.value))
        updateControls()
    }
    
    @IBAction func togglePlayingState(button: UIButton) {
        player.isPlaying = !button.isSelected
        updateControls()
    }
    
    @IBAction func skip(button: UIButton) {
        player.skip()
        updateControls()
    }
    
    @IBAction func goBack(button: UIButton) {
        player.goBack()
        updateControls()
    }
}

