//
//  GamesApiProtocol.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

protocol GamesApiProtocol {
    func requestGames(completion: @escaping (Result<GamesResponseDto, GamesApiError>) -> Void)
}
