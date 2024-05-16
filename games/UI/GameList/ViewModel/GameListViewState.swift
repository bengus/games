//
//  GameListViewState.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

struct GameListViewState:  Equatable {
    let sectionItems: [DateSectionItem]
    let isLoading: Bool
    
    static func empty() -> Self {
        return GameListViewState(
            sectionItems: [],
            isLoading: false
        )
    }
}

extension GameListViewState {
    struct DateSectionItem: Equatable {
        let dateText: String
        let gameItems: [GameItemType]
        
        init(
            date: Date,
            gameItems: [GameItemType]
        ) {
            self.dateText = dateFormatter.string(from: date)
            self.gameItems = gameItems
        }
    }
    
    enum GameItemType: Equatable {
        case competition(CompetitionItem)
        case game(GameItem)
    }
    
    struct CompetitionItem: Equatable {
        let competitionName: String
        
        init(competition: Competition) {
            self.competitionName = competition.name
        }
    }
    
    struct GameItem: Equatable {
        let team1NameText: String?
        let team2NameText: String?
        let currentTimeText: String?
        /// Future game: display startTime
        /// Live/Finished game: display scores
        let centeredTableuText: String?
        
        init(game: Game) {
            if game.competitors.count > 1 {
                self.team1NameText = game.competitors[0].name
                self.team2NameText = game.competitors[1].name
            } else {
                self.team1NameText = nil
                self.team2NameText = nil
            }
            
            var scoresText: String?
            if game.scores.count > 1 {
                scoresText = "\(game.scores[0]):\(game.scores[1])"
            }
            let timeText: String = timeFormatter.string(from: game.startTime)
            
            switch game.status {
            case .active:
                self.centeredTableuText = scoresText
                self.currentTimeText = "\(game.gameTime)'"
            case .future:
                self.centeredTableuText = timeText
                self.currentTimeText = nil
            case .finished:
                self.centeredTableuText = scoresText
                self.currentTimeText = nil
            case .unknown:
                self.centeredTableuText = nil
                self.currentTimeText = nil
            }
        }
    }
}

// To simplify Demo put Formatters to display time here
// Depends on the situation it would be better to move it into smth like Formatting facade.
// Format: HH:mm
private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar.autoupdatingCurrent
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.autoupdatingCurrent
    formatter.dateFormat = "HH:mm"
    return formatter
}()
// Format: dd/MM/yyyy
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar.autoupdatingCurrent
    formatter.locale = Locale.current
    formatter.timeZone = TimeZone.autoupdatingCurrent
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter
}()
