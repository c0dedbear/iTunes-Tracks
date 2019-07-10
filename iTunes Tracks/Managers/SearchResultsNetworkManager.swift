//
//  SearchResultsNetworkManager.swift
//  Itunes Samples
//
//  Created by Михаил Медведев on 03/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class SearchResultsNetworkManager {
    
    static let shared = SearchResultsNetworkManager()
    private init() {}
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var parameters = [
        "term":"",
        "media":"music"
    ]
    
    func fetchSearchResults(completion: @escaping (ItunesSearchResults?) -> Void ) {
        guard let url = baseURL.withQueries(parameters) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return }
            
            let decoder = JSONDecoder()
            let searchResults = try? decoder.decode(ItunesSearchResults.self, from: data)
            
            completion(searchResults)
            
        }.resume()
    }
    
    func fetchImage(from url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = url else {
            print("Invalid URL of Image")
            return }
        URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
}
