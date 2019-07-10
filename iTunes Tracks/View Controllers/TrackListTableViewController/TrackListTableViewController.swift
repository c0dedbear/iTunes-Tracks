//
//  TrackListTableViewController.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import UIKit
import SafariServices

class TrackListTableViewController: UITableViewController {
    
    let cellManager = CellManager()
    var searchResults: ItunesSearchResults?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func listenOnAppleMusicButtonPressed(_ sender: UIButton) {
        //define indexPath using sender position
        let buttonPostion = sender.convert(sender.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPostion) {
            let rowIndex =  indexPath.row
            print(rowIndex)
            guard let track = searchResults?.results?[rowIndex] else { return }
            guard let url = URL(string: track.trackViewUrl!) else { return }
            openSafari(with: url)

        }
    
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
        cellManager.configure(cell, using: track, withImage: track?.imageURL)
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
    }
    
}


// MARK: - UIScrollView Delegate
extension TrackListTableViewController {
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationBarVisibilityToggle()
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

// MARK: - Open track in Apple Music
extension TrackListTableViewController {
    private func openSafari(with url: URL) {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = true
        let safariController = SFSafariViewController(url: url, configuration: configuration)
        present(safariController, animated: true)
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
