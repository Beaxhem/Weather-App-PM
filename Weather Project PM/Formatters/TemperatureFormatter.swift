//
//  TemperatureFormatter.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import Foundation

protocol TemperatureFormatter {
    func string(temp: Float) -> String
    func string(temp: Double) -> String
}

class RoundTemperatureFormatter: TemperatureFormatter {
    func string(temp: Float) -> String {
        return "\(Int(temp.rounded()))°"
    }
    
    func string(temp: Double) -> String {
        return "\(Int(temp.rounded()))°"
    }
}
