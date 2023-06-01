//
//  DateUtil.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 29.03.2023.
//

import Foundation

final class DateUtil {
    
    static func getString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        return dateString
    }
    
}
