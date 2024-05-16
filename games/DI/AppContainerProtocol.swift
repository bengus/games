//
//  AppContainerProtocol.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation
import UIKit

protocol AppContainerProtocol {
    // Services
    var gamesProvider: GamesProvider { get }
    
    // UI Modules factories
    func gameListScreenFactory() -> UIViewController
    
}
