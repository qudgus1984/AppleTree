//
//  CountStruct.swift
//  AppleTree
//
//  Created by 이병현 on 2022/09/14.
//

import Foundation

class DateFormatterHelper {
    
    private init() {}
    
    static let Formatter = DateFormatterHelper()
    let dateFormatter = DateFormatter()
    func formatDate() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var dateStr: String {
        get {
            formatDate()
            return dateFormatter.string(from: Date())
        }
    }
    
    var yesterDayStr: String {
        get {
            formatDate()
            return dateFormatter.string(from: Date() - 86400)
        }
    }
    
    func selectDay(day: Date) -> String {
        formatDate()
        return dateFormatter.string(from: day)
    }
    
}
