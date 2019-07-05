//
//  NavigationBarVisibility.swift
//  iTunes Tracks
//
//  Created by Михаил Медведев on 04/07/2019.
//  Copyright © 2019 Михаил Медведев. All rights reserved.
//

import Foundation

// MARK: - navigationBarVisibilityToggle

extension TrackListTableViewController {
    func navigationBarVisibilityToggle() {
        if navigationController?.navigationBar.isHidden == true {
           navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}
