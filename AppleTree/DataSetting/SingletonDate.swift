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
    let date = Date()    
    func formatDate() {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var dateStr: String {
        get {
            formatDate()
            print("✅✅",date)
            return dateFormatter.string(from: date)
        }
    }
    
    var yesterDayStr: String {
        get {
            formatDate()
            return dateFormatter.string(from: date - 86400)
        }
    }
}
