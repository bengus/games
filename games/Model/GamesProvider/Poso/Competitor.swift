//
//  Competitor.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

struct Competitor: Identifiable, Equatable {
    /// competitor identifier
    let id: Int
    /// competitor (team) name
    let name: String
}

extension Competitor {
    static func from(dto: CompetitorDto) -> Self {
        Competitor(
            id: dto.id,
            name: dto.name
        )
    }
}
