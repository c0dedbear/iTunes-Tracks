//
//  CellManager.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 10/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class CellManager {
    
    func configure(_ cell: TrackTableViewCell, using track: Track?, withImage url: URL?) {
        SearchResultsNetworkManager.shared.fetchImage(from: url) { image in
            if let image = image {
                OperationQueue.main.addOperation {
                    cell.albumImageView.image = image
                    
                }
            }
        }
        
        cell.trackNameLabel.text = track?.trackName ?? ""
        cell.artistLabel.text = track?.artistName ?? ""
        cell.albumLabel.text = track?.collectionName ?? ""
        
        
        cell.trackSlider.setThumbImage(UIImage(named: "clearthumb"), for: .normal)
        cell.trackSlider.setThumbImage(UIImage(named: "thumb"), for: .highlighted)
        
        if let audioUrl = track?.audioURL {
            let playerItem = AudioPlayer.getPlayerItem(with: audioUrl)
            cell.player = AudioPlayer(playerItem: playerItem)
        }
        
    }
}
