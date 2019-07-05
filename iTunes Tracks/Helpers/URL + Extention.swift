//
//  URL + Extention.swift
//  Itunes Samples
//
//  Created by Михаил Медведев on 03/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value)}
        return components?.url
    }
}

