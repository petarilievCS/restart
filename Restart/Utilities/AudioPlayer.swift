//
//  AudioPlayer.swift
//  Restart
//
//  Created by Petar Iliev on 6/15/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(_ name: String, _ type: String) {
    if let soundPath = Bundle.main.path(forResource: name, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            audioPlayer?.play()
        } catch {
            print("Error: Failed to play sound")
        }
    } else {
        print("Error: Sound not found")
    }
}


