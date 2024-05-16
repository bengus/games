//
//  Calendar+.swift
//  games
//
//  Created by Boris Bengus on 16/05/2024.
//

import Foundation

public extension Calendar {
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let components1 = self.dateComponents([.day, .month, .year], from: date1)
        let components2 = self.dateComponents([.day, .month, .year], from: date2)
        
        if components1.year == components2.year &&
            components1.month == components2.month &&
            components1.day == components2.day {
            
            return true
        }
        
        return false
    }
    
    func nullifiedTimeDate(from date: Date) -> Date {
        var components = self.dateComponents([.day, .month, .year], from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        components.nanosecond = 0
        
        let nullifiedTimeDate = self.date(from: components)
        assert(nullifiedTimeDate != nil, "Can't create nullifiedTimeDate from date")
        
        return nullifiedTimeDate ?? date
    }
}
