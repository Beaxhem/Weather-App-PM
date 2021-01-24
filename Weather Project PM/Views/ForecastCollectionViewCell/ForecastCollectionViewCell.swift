//
//  ForecastCollectionViewCell.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    static let id = "ForecastCollectionViewCell"
    
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var dayTempLabel: UILabel?
    @IBOutlet weak var nightTempLabel: UILabel?
    
    private let tempFormatter = RoundTemperatureFormatter()
    
    func configure(with prediction: Prediction) {
        dateLabel?.text = prediction.date
        dayTempLabel?.text = tempFormatter.string(temp: prediction.temp.day)
        nightTempLabel?.text = tempFormatter.string(temp: prediction.temp.night)
    }
}
