//
//  TrackTableViewCell.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit
import AVFoundation

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var player: AudioPlayer!
    let playButtonImage = UIImage(named: "playbutton")
    let pauseButtonImage = UIImage(named: "pausebutton")
    
    func configure(using track: Track?, withImage urlString: String?) {
        
        SearchResultsNetworkManager.shared.fetchImage(from: urlString) { image in
            if let image = image {
                OperationQueue.main.addOperation {
                    self.albumImageView.image = image
                }
            }
        }
        
        trackNameLabel.text = track?.trackName ?? ""
        artistLabel.text = track?.artistName ?? ""
        albumLabel.text = track?.collectionName ?? ""
        
        //audio playback
        trackSlider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        trackSlider.setThumbImage(UIImage(named: "thumb"), for: .highlighted)
        
        if let url = track?.audioURL {
            let playerItem = AudioPlayer.configureItem(with: url)
            player = AudioPlayer(playerItem: playerItem)
        }
        
    }
    
    func updateTrackSlider() {
        guard let player = player else { return }
        guard let currentItem = player.currentItem else { return }
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            self?.trackSlider.maximumValue = Float(currentItem.duration.seconds)
            self?.trackSlider.value = Float(time.seconds)
            if time == player.currentItem?.duration || self?.playPauseButton.image(for: .normal) == self?.playButtonImage {
                player.seek(to: CMTimeMake(value: 0, timescale: 1))
                player.pause()
                self?.playPauseButton.setImage(self?.playButtonImage, for: .normal)
                // player.removeTimeObserver(player)
            }
            
        }
        
        
        
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        guard let player = player else {
            print("player not installed")
            return }
        sender.setImage(player.isPlaying ? playButtonImage : pauseButtonImage , for: .normal)
        if player.isPlaying {
            player.pause()
            UIView.animate(withDuration: 0.5) {
                self.trackSlider.alpha = 0
            }
        } else {
            // updateTrackSlider()
            player.play()
            UIView.animate(withDuration: 0.5) {
                self.trackSlider.alpha = 1
            }
        }
        
    }
    
}


