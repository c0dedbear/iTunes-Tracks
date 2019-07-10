//
//  AudioPlayer.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayer: AVPlayer {
    
    static func getPlayerItem(with url: URL?) -> AVPlayerItem? {
        guard let url = url else { return nil }
        let item = AVPlayerItem(url: url)
        return item
    }
    
    func seekTrack(using slider: UISlider) {
        let sliderValue = Double(slider.value)
        let time = CMTime(value: CMTimeValue(sliderValue), timescale: 1)
        seek(to: time)
    }
    
}

extension AudioPlayer {
    
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
