//
//  CityCollectionViewCell.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    static let id = "CityCollectionViewCell"
    
    @IBOutlet weak var cityName: UILabel?
    @IBOutlet weak var temperature: UILabel?
    @IBOutlet weak var timeLabel: UILabel?
    
    let tempFormatter = RoundTemperatureFormatter()
    let hoursFormatter = HoursDateFormatter()
    
    func configure(with weather: WeatherModel) {
        cityName?.text = weather.name
        temperature?.text = tempFormatter.string(temp: weather.main.currentTemp)
        timeLabel?.text = getRequestDate()
        
        addBottomBorder()
    }
    
    func getRequestDate() -> String {
        let date = Date()
        
        return hoursFormatter.string(from: date)
    }
}
