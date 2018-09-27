//  Created by Nikola Lajic on 9/18/18.
//  Copyright © 2018 Nikola Lajic. All rights reserved.

import UIKit

class EqualizerViewController: UIViewController {
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var bassLabel: UILabel!
    @IBOutlet weak var bassSlider: UISlider!
    @IBOutlet weak var trebleLabel: UILabel!
    @IBOutlet weak var trebleSlider: UISlider!
    var player = Player.sharedInstance
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateControls()
        updateLabels()
    }
    
    func updateLabels() {
        volumeLabel.text = "Volume: \(player.volume)%"
        bassLabel.text = "Bass: \(player.bass)%"
        trebleLabel.text = "Treble: \(player.treble)%"
    }
    
    func updateControls() {
        volumeSlider.value = Float(player.volume)
        bassSlider.value = Float(player.bass)
        trebleSlider.value = Float(player.treble)
    }
}

extension EqualizerViewController {
    @IBAction func volumeSliderValueChanged(slider: UISlider) {
        player.volume = Int(round(slider.value))
        updateLabels()
    }
    
    @IBAction func bassSiliderValueChanged(slider: UISlider) {
        player.bass = Int(round(slider.value))
        updateLabels()
    }
    
    @IBAction func trebleSliderValueChanged(slider: UISlider) {
        player.treble = Int(round(slider.value))
        updateLabels()
    }
}
