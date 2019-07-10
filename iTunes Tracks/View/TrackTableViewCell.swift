//
//  TrackTableViewCell.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit
import AVFoundation
import SafariServices

class TrackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var listenOnAppleMusicButton: UIButton!
    
    var player: AudioPlayer!
    
    let playButtonImage = UIImage(named: "playbutton")
    let pauseButtonImage = UIImage(named: "pausebutton")
    
    func updateTrackSlider() {
        guard let player = player else { return }
        guard let currentItem = player.currentItem else { return }
        guard currentItem.status.rawValue == AVPlayerItem.Status.readyToPlay.rawValue else { return }
        let durationSeconds = Float(currentItem.duration.seconds)
        trackSlider.maximumValue = durationSeconds
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { [weak self] time in
            self?.trackSlider.value = Float(time.seconds)
            if time == currentItem.duration {
                player.seek(to: CMTimeMake(value: 0, timescale: 1))
                player.pause()
                self?.playPauseButton.setImage(self?.playButtonImage, for: .normal)
                UIView.animate(withDuration: 0.5) {
                    self?.trackSlider.alpha = 0
                }
                
                UIView.animate(withDuration: 0.75, animations: {
                    self?.listenOnAppleMusicButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }, completion: { completion in
                    if completion {
                        self?.listenOnAppleMusicButton.transform = CGAffineTransform.identity
                    }
                }
                )
            }
        }
        
        
    }
    
    @IBAction func trackSliderValueChanged(_ sender: UISlider) {
        guard let player = player else { return }
        guard let currentItem = player.currentItem else { return }
        guard currentItem.status.rawValue == AVPlayerItem.Status.readyToPlay.rawValue else { return }
        player.seekTrack(using: sender)
    }
    
    @IBAction func playPauseButtonPressed(_ sender: UIButton) {
        guard let player = player else { return }
        guard let currentItem = player.currentItem else { return }
        guard currentItem.status.rawValue == AVPlayerItem.Status.readyToPlay.rawValue else { return }
        UIView.animate(withDuration: 0.25) {
            sender.alpha = 1
        }
        sender.setImage(player.isPlaying ? playButtonImage : pauseButtonImage , for: .normal)
        if player.isPlaying {
            player.pause()
            UIView.animate(withDuration: 0.5) {
                self.trackSlider.alpha = 0
            }
        } else {
            player.play()
            updateTrackSlider()
            UIView.animate(withDuration: 0.5) {
                self.trackSlider.alpha = 1
            }
        }
        
    }
    
    
}
