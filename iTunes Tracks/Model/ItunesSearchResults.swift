//
//  ItunesSearchResults.swift
//  Itunes Samples
//
//  Created by Михаил Медведев on 03/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import Foundation

struct ItunesSearchResults: Codable {
    let results: [Track]?
}

// MARK: - Result
struct Track: Codable {
    let artistName: String?
    let trackName: String?
    let collectionName: String?
    let audioURL: URL? // url for sample file
    let imageURL: URL? // picture of album
    let trackViewUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case artistName, trackName, collectionName
        case audioURL = "previewUrl"
        case imageURL = "artworkUrl100"
        case trackViewUrl
    }
}
