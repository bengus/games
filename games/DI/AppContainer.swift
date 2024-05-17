//
//  AppContainer.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit

final class AppContainer: AppContainerProtocol {
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        configuration.timeoutIntervalForRequest = 10
        return URLSession(configuration: configuration)
    }()
    
    // It could be in future a Calendar configured with user-selecrted timezone
    private lazy var calendar = Calendar.autoupdatingCurrent
    
    
    // MARK: - Init
    init() {
        // Here usually could be an environment detection
        // reading bundle env values
        // checking local build config
    }
    
    
    // MARK: - AppContainerProtocol
    private(set) lazy var gamesProvider: GamesProvider = {
        return GamesProvider(
            gamesApi: GamesApi(urlSession: self.urlSession),
            calendar: self.calendar
        )
    }()
    
    func gameListScreenFactory() -> UIViewController {
        let viewModel = GameListViewModel(
            initialState: .empty(),
            gamesProvider: self.gamesProvider
        )
        return GameListViewController(
            viewModel: viewModel,
            viewFactory: { vm in GameListView(viewModel: vm) }
        )
    }
}
