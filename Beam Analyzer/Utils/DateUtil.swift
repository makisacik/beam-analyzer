//
//  DateUtil.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 29.03.2023.
//

import Foundation

class DateUtil {
    static func getString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        print(dateString)
        return dateString
    }
    
    static func getDate(from string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        return dateFormatter.date(from: string) ?? Date()
    }

}
