//
//  GameListViewController.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import UIKit

class GameListViewController: MvvmUIKitViewController
<
    GameListView,
    GameListViewModel,
    GameListViewState,
    GameListViewModel.ViewAction,
    GameListViewModel.Eff
>
{
    // MARK: - State and effects
    override func onEffect(_ eff: GameListViewModel.Eff) {
        super.onEffect(eff)
        
        switch eff {
        case .showError(let localizedError):
            showError(localizedError: localizedError)
        }
    }
    
    // Skip localization (Localizable.strings and so on) because of Demo...
    private func showError(localizedError: String) {
        let alertController = UIAlertController(
            title: "Ups..",
            message: localizedError,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: { _ in }
        ))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
