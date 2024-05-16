//
//  Game.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

struct Game {
    enum Status {
        case active
        case future
        case finished
        case unknown
    }
    
    /// game identifier
    let id: Int
    /// current game status
    let statusId: Int
    /// date and time the game was/will be played on
    let startTime: Date
    /// identifier of a competition the game is related to
    let competition: Competition?
    /// indicates whether the game is live
    let active: Bool
    /// live game minute
    let gameTime: Int
    /// an array of competitors participating in the game
    let competitors: [Competitor]
    /// array representing the game score. Only two first indexes are relevant
    let scores: [Int]
    
    var status: Status {
        if statusId == 2 {
            return .future
        } else if statusId == 3 {
            return .finished
        } else if active == true {
            return .active
        } else {
            return .unknown
        }
    }
}

// Mapping code is very simple in this case.
// So, don't need to create separate Mapper classes.
// Move forward with static fabric-methods.
extension Game {
    static func from(
        dto: GameDto,
        competitionDto: CompetitionDto?
    ) -> Self {
        Game(
            id: dto.id,
            statusId: dto.stid,
            startTime: dto.sTime,
            competition: Competition.from(dto: competitionDto),
            active: dto.active,
            gameTime: dto.gt,
            competitors: dto.comps.map { Competitor.from(dto: $0) },
            scores: dto.scrs
        )
    }
}
