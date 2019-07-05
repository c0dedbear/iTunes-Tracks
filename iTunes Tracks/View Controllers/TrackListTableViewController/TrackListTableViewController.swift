//
//  TrackListTableViewController.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit

class TrackListTableViewController: UITableViewController {
    
    var searchResults: ItunesSearchResults?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
}

// MARK: - Table view data source
extension TrackListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resultCount = searchResults?.results?.count {
                return resultCount
        } else {
             tableView.setEmptyView(title: "", message: "There will be shown searching tracks")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackTableViewCell
        let track = searchResults?.results?[indexPath.row]
        cell.configure(using: track, withImage: track?.imageURL)
        return cell
    }
    
    
}

// MARK: - Table view delegate
extension TrackListTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

        override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let cell = cell as! TrackTableViewCell
                cell.playPauseButton.setImage(cell.playButtonImage, for: .normal)
                cell.trackSlider.alpha = 0
                cell.player.pause()
               // cell.updateTrackSlider()

        }
}

// MARK: - Fetching Results
extension TrackListTableViewController {
    func fetchSearchResults() {
        SearchResultsNetworkManager.shared.fetchSearchResults { result in
            guard let result = result else { return }
            self.searchResults = result
            OperationQueue.main.addOperation {
                self.tableView.reloadSections([0], with: .fade)
            }
        }
    }
}

// MARK: - Keyboard
extension TrackListTableViewController {
    func hideKeyboardFromTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        if navigationController!.navigationBar.isHidden {
            view.endEditing(true)
            navigationBarVisibilityToggle()
        }
    }
    
}
