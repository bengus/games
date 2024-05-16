//
//  String+.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import Foundation

extension String {
   var isUppercased: Bool {
       return self == self.uppercased()
   }
    
    func decapitalizingFirstLetter() -> String {
        let first = String(prefix(1)).lowercased()
        let other = String(dropFirst())
        return first + other
    }
}
