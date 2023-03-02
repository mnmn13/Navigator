//
//  Time.swift
//  NavigatorApp
//
//  Created by MN on 28.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

class Time {
    
    static func dateToString(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd,MM,yy,HH,mm,ss"
//        formatter.timeZone = .current
//        formatter.timeZone = .gmt
        let string = formatter.string(from: date)
        
        return string
        
    }
    
    static func stringToDate(string: String) -> Date {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd,MM,yy,HH,mm,ss"
//        formatter.timeZone = .current
        formatter.timeZone = .gmt
        guard let date = formatter.date(from: string) else { return Date() }
        return date
        
    }
}
