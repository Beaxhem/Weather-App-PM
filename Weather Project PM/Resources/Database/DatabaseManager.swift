//
//  DatabaseManager.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 23.01.2021.
//

import UIKit

class DatabaseManager {
    var citiesIDs: [String] = UserDefaults.standard.stringArray(forKey: "citiesIDs")!
    var weatherData: [WeatherModel] = []
    
    static let shared = DatabaseManager()
    
    func fetchWeatherData(completion: (() -> Void)? = nil) {
        WeatherManager.shared.loadCurrentWeatherForMultipleCities(citiesIDs: citiesIDs) { [weak self] res in
            switch res {
            case .failure(let error):
                print(error)
            case .success(let result):
                self?.weatherData = result
                completion?()
            }
        }
    }
}
