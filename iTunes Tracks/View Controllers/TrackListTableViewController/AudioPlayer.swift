//
//  AudioPlayer.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer: AVPlayer {
    
    static func configureItem(with urlString: String?) -> AVPlayerItem? {
        guard let urlString = urlString else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        let item = AVPlayerItem(url: url)
        return item
    }
    
}

extension AudioPlayer {
    
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
