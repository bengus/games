//
//  Design.swift
//  games
//
//  Created by Boris Bengus on 16/05/2024.
//

import Foundation
import UIKit

enum Design {
    // Facade to work with Design system. Here could be placed things like:
    // isIpad, isRTL, theme - { light or dark }.
    // Colors could be changed accordingly to current context (system theme or user-selected skin)
    
    enum Metrics {
        static let smallVerticalGap: CGFloat = 4
        static let verticalGap: CGFloat = 10
        static let bigVerticalGap: CGFloat = 20
        static let smallHorizontalGap: CGFloat = 8
        static let horizontalGap: CGFloat = 16
        static let bigHorizontalGap: CGFloat = 36
    }
    
    enum Colors {
        static var primaryText: UIColor { .black }
        static var secondaryText: UIColor { .darkGray }
        static var defaultBackground: UIColor { .white }
        static var loadingIndicatorGray: UIColor { .gray }
        static var loadingBackdropColor: UIColor { .black.withAlphaComponent(0.3) }
        
        // Here could be declared other Colors and also Palette from Design team
    }
    
    enum Fonts {
        static func regular(ofSize size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        static func semibold(ofSize size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        static func bold(ofSize size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
        
        public static var smallText: UIFont { regular(ofSize: 12) }
        public static var defaultText: UIFont { regular(ofSize: 14) }
        public static var mediumText: UIFont { regular(ofSize: 16) }
        public static var bigText: UIFont { regular(ofSize: 18) }
        
        // Here should be also declared mostly all popular textstyles like
        // public static var heading1 = ...
        // public static var heading2 = ...
        // public static var body = ...
        // public static var caption = ...
    }
}
