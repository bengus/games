//
//  GamesResponseDto.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

struct GamesResponseDto: Codable {
    let games: [GameDto]
    let competitions: [CompetitionDto]
}
