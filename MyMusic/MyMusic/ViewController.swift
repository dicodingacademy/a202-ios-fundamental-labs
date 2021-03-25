//
//  ViewController.swift
//  MyMusic
//
//  Created by Gilang Ramadhan on 16/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    private var _player: AVAudioPlayer?
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton.disable()
        guard let url = Bundle.main.url(forResource: "guitar_background", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)

            /* Kode ini untuk iOS 11 ke atas */
            _player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* Sedangkan untuk iOS 10 ke bawah gunakan ini:
             _player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func playMusic(_ sender: UIButton) {
        guard let player = _player else { return }
        player.play()
        stopButton.enable()
        playButton.disable()
    }

    @IBAction func stopMusic(_ sender: UIButton) {
        guard let player = _player else { return }
        player.stop()
        playButton.enable()
        stopButton.disable()
    }
}

extension UIButton {
    func enable() {
        self.isEnabled = true
    }

    func disable() {
        self.isEnabled = false
    }
}
