//
//  GamesError.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

enum GamesError: LocalizedError {
    case cantUpdateGames(reason: Error?)
    
    var errorDescription: String? {
        // Skip localization because of Demo
        switch self {
        case .cantUpdateGames(_):
            return "Can't update games, please try again"
        }
    }
}
