//
//  CustomDateFormatter.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import Foundation

class HoursDateFormatter: DateFormatter {
    override func string(from date: Date) -> String {
        dateFormat = "HH:mm"
        
        return super.string(from: date)
    }
}
