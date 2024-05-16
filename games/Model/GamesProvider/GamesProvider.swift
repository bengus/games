//
//  GamesProvider.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import OrderedCollections

class GamesProvider {
    private let gamesApi: GamesApiProtocol
    private let callbackQueue: DispatchQueue
    private let calendar: Calendar
    
    // To simplify Demo won't use smth like CoreData, Realm or smth else.
    // Just keep current games in-memory
    private var games = [Game]()
    // Also keep games by date OrderedDictionary to quick access by Date key
    private var gamesByDates = OrderedDictionary<Date, [Game]>()
    
    
    // MARK: - Init
    init(
        gamesApi: GamesApiProtocol,
        callbackQueue: DispatchQueue = DispatchQueue.main,
        calendar: Calendar
    ) {
        self.gamesApi = gamesApi
        self.callbackQueue = callbackQueue
        self.calendar = calendar
    }
    
    
    // MARK: - GamesProvider
    private func saveGames(games: [Game]) {
        self.games = games
        // Rebuild gamesByDate map
        // Use swift-collections OrderedDictionary implementation.
        // But now we can use swift-collections.
        // Why we can't use standard Dictionary? - because it's keys are unordered.
        var gamesByDates = OrderedDictionary<Date, [Game]>()
        for game in games {
            let key = calendar.nullifiedTimeDate(from: game.startTime)
            var gamesToSet = gamesByDates[key] ?? [Game]()
            gamesToSet.append(game)
            gamesByDates[key] = gamesToSet
        }
        self.gamesByDates = gamesByDates
    }
    
    func getAllGames() -> [Game] {
        return games
    }
    
    func getGamesByDates() -> OrderedDictionary<Date, [Game]> {
        return gamesByDates
    }
    
    func updateGames(completion: @escaping (Result<Void, GamesError>) -> Void) {
        gamesApi.requestGames { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let responseDto):
                // First fill-in competitions dictionary to have a map of competitions by it's IDs
                // It's require to not iterate though all array each time we need to find competition by id
                var competitionsDtoMap = [Int: CompetitionDto]()
                for eachCompetition in responseDto.competitions {
                    competitionsDtoMap[eachCompetition.id] = eachCompetition
                }
                let games = responseDto.games.map {
                    Game.from(
                        dto: $0,
                        competitionDto: competitionsDtoMap[$0.comp]
                    )
                }
                self.saveGames(games: games)
                callbackQueue.async {
                    completion(.success(()))
                }
            case .failure(let error):
                callbackQueue.async {
                    completion(.failure(GamesError.cantUpdateGames(reason: error)))
                }
            }
        }
    }
}
