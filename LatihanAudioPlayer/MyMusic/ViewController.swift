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
  // MARK: Inisialisasi variabel player
  private var player: AVAudioPlayer?

  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    // MARK: Memastikan bahwa url dari asset tidak null.
    guard let url = Bundle.main.url(
      forResource: "guitar_background",
      withExtension: "mp3"
    ) else {
      return
    }

    // MARK: Setup AVAudioPlayer
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)

      // MARK: Kode ini untuk iOS 11 ke atas.
      player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

      // MARK: Kode ini untuk iOS 10 ke bawah.
      // player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)

    } catch let error {
      print(error.localizedDescription)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    isPlaying(state: false)
  }

  // MARK: Memainkan Musik
  @IBAction func playMusic(_ sender: UIButton) {
  guard let audioPlayer = player else { return }
    audioPlayer.play()
    isPlaying(state: true)
  }

  // MARK: Menghentikan Musik
  @IBAction func stopMusic(_ sender: UIButton) {
  guard let audioPlayer = player else { return }
    audioPlayer.stop()
    isPlaying(state: false)
  }

  private func isPlaying(state: Bool) {
    stopButton.isEnabled = state
    playButton.isEnabled = !state
  }
}
