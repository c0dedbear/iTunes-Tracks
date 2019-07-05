//
//  SearchBarDelegate.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

// MARK: - UISearchBarDelegate
extension TrackListTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationBarVisibilityToggle()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
            SearchResultsNetworkManager.shared.parameters["term"] = searchBar.text
            fetchSearchResults()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let _ = searchBar.text else { return }
    }
    
}


