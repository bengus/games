//
//  GamesApiError.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

public enum GamesApiError: Error {
    case generalNetworkError(reason: Error?)
    case invalidStatus(status: Int)
    case invalidResponse(reason: Error?)
}
