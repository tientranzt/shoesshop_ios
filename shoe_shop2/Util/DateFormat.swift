//
//  FormatDate.swift
//  shoe_shop2
//
//  Created by huent18 on 5/19/21.
//

import Foundation

class DateFormat {
    
    static func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        return formatter.string(from: date)
    }
}
