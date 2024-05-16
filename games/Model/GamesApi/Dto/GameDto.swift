//
//  GameDto.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

struct GameDto: Codable {
    /// game identifier
    let id: Int
    /// current game status
    let stid: Int
    /// date and time the game was/will be played on
    let sTime: Date
    /// identifier of a competition the game is related to
    let comp: Int
    /// indicates whether the game is live
    let active: Bool
    /// live game minute
    let gt: Int
    /// an array of competitors participating in the game
    let comps: [CompetitorDto]
    /// array representing the game score. Only two first indexes are relevant
    let scrs: [Int]
}
