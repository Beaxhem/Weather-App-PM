//
//  ResultsTableViewCell.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    static let id = "ResultsTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    
    let temperatureFormatter = RoundTemperatureFormatter()
    
    func configure(with weatherModel: OneCityQuery) {
        titleLabel?.text = weatherModel.name
        temperatureLabel?.text = temperatureFormatter.string(temp: weatherModel.main.currentTemp)
    }
}
