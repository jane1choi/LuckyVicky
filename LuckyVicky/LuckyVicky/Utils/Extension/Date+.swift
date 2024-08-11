//
//  Date+.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/11/24.
//

import Foundation

extension Date {
    
    var today: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
}
