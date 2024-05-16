//
//  GamesApi.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

final class GamesApi: GamesApiProtocol {
    private let urlSession: URLSession
    private let callbackQueue: DispatchQueue
    
    // I decided to move forward with Codable, but if you need to check if I can parse json mannualy, I can))
    private lazy var jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .gamesApiKeyDecodingStrategy
        // In Demo we have the only one case of date format "dd-MM-yyyy HH:mm".
        // In other cases it would be better to handle it mannually or in custom strategy
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    
    // MARK: - Init
    init(
        urlSession: URLSession,
        callbackQueue: DispatchQueue = DispatchQueue.main
    ) {
        self.urlSession = urlSession
        self.callbackQueue = callbackQueue
    }
    
    
    // MARK: - GamesApiProtocol
    func requestGames(completion: @escaping (Result<GamesResponseDto, GamesApiError>) -> Void) {
        let request = URLRequest(url: URL(string: "https://demo2170822.mockable.io/assignment")!)
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else { return }
            
            if let error = error {
                callbackQueue.async {
                    completion(.failure(GamesApiError.generalNetworkError(reason: error)))
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                callbackQueue.async {
                    completion(.failure(GamesApiError.generalNetworkError(reason: nil)))
                }
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let data = data else {
                    callbackQueue.async {
                        completion(.failure(GamesApiError.invalidResponse(reason: nil)))
                    }
                    return
                }
                do {
                    let responseDto = try jsonDecoder.decode(GamesResponseDto.self, from: data)
                    callbackQueue.async {
                        completion(.success(responseDto))
                    }
                } catch(let error) {
                    callbackQueue.async {
                        completion(.failure(GamesApiError.invalidResponse(reason: error)))
                    }
                }
            default:
                callbackQueue.async {
                    completion(.failure(GamesApiError.invalidStatus(status: response.statusCode)))
                }
            }
        }
        task.resume()
    }
}

private extension JSONDecoder.KeyDecodingStrategy {
    static var gamesApiKeyDecodingStrategy: Self {
        return .custom({ keys in
            let lastKey = keys.last!
            let originalKey = lastKey.stringValue
            let updatedKey: String
            if originalKey.isUppercased {
                // SID -> sid, ID -> id, STID -> stid
                updatedKey = originalKey.lowercased()
            } else {
                // StatusSequence -> statusSequence
                updatedKey = originalKey.decapitalizingFirstLetter()
            }
            return AnyCodingKey(stringValue: updatedKey) ?? lastKey
        })
    }
}

// To simplify Demo put Formatter for decoding dates here.
// Depends on the situation it would be better to move it into smth like Formatting facade.
// example "STime": "27-01-2024 19:30"
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    // Also it's important to understand that we don't know what timezone Backend send us.
    // I will try to guess and will move forward with UTC
    formatter.timeZone = TimeZone(identifier: "UTC")
    formatter.dateFormat = "dd-MM-yyyy HH:mm"
    return formatter
}()
