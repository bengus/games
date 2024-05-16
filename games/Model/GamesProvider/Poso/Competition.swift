//
//  Competition.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

struct Competition: Identifiable, Equatable {
    /// competition identifier
    let id: Int
    /// competition (league) name
    let name: String
}

extension Competition {
    static func from(dto: CompetitionDto?) -> Self? {
        guard let dto else { return nil }
        
        return Competition(
            id: dto.id,
            name: dto.name
        )
    }
}
