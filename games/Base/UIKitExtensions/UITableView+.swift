//
//  UITableView+.swift
//  games
//
//  Created by Boris Bengus on 17/05/2024.
//

import Foundation
import UIKit

public extension UITableView {
    func stopRefreshControl() {
        guard let refreshControl else { return }
        // Stop only in case if we didn't stop before
        if refreshControl.isRefreshing {
            // It's little bit hacky but robust.
            // It's needed to prevent contentOffset animation stuck
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                refreshControl.endRefreshing()
            }
        }
    }
    
    /// In most cases refreshControl is triggered by user
    /// But sometimes we need to sync ViewState with actual UI
    func startRefreshControl(animated: Bool) {
        guard let refreshControl else { return }
        // Start only in case if we didn't start before
        if  !refreshControl.isRefreshing {
            refreshControl.beginRefreshing()
            let contentOffset = CGPoint(x: 0, y: -refreshControl.frame.height)
            self.setContentOffset(contentOffset, animated: animated)
        }
    }
}
