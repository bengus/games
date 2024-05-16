//
//  GameListViewModel.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

class GameListViewModel:
    ViewModel
<
    GameListViewState,
    GameListViewModel.ViewAction,
    GameListViewModel.Eff
>
{
    private let gamesProvider: GamesProvider
    private let calendar: Calendar
    // Boolean flag maybe not the best solution, but robust for this case in Demo
    private var isUpdatingInProgress = false
    
    
    // MARK: - Init
    init(
        initialState: GameListViewState,
        gamesProvider: GamesProvider,
        calendar: Calendar
    ) {
        self.gamesProvider = gamesProvider
        self.calendar = calendar
        
        super.init(initialState: initialState)
    }
    
    
    // MARK: - Lifecycle
    override func onViewWillAppear() {
        super.onViewWillAppear()
        update()
    }
    
    
    // MARK: - ViewActions
    override func onViewAction(_ action: ViewAction) {
        switch action {
        case .pullToRefresh:
            update()
        }
    }
    
    private func update() {
        isUpdatingInProgress = true
        reload()
        gamesProvider.updateGames { [weak self] result in
            guard let self else { return }
            
            self.isUpdatingInProgress = false
            self.reload()
            if case .failure(let error) = result {
                publishEffect(.showError(localizedError: error.localizedDescription))
            }
        }
    }
    
    private func reload() {
        var sectionItems = [GameListViewState.DateSectionItem]()
        for (date, games) in gamesProvider.getGamesByDates() {
            var currentCompetition: Competition?
            var gameItems = [GameListViewState.GameItemType]()
            for game in games {
                // In case of competition is changed between prev and current - add CompetitionItem
                if
                    let competition = game.competition,
                    currentCompetition != competition
                {
                    gameItems.append(.competition(GameListViewState.CompetitionItem(
                        competition: competition
                    )))
                }
                // In all cases add GameItem
                gameItems.append(.game(GameListViewState.GameItem(
                    game: game
                )))
            }
            sectionItems.append(GameListViewState.DateSectionItem(
                date: date,
                gameItems: gameItems
            ))
            currentCompetition = nil
            gameItems = []
        }
        publishState(GameListViewState(
            sectionItems: sectionItems,
            isLoading: isUpdatingInProgress
        ))
    }
}

extension GameListViewModel {
    /// Actions that could published from View
    enum ViewAction {
        case pullToRefresh
    }
    
    /// Effects that could be published from ViewModel
    enum Eff {
        case showError(localizedError: String)
    }
}
