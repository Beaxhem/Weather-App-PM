//
//  DatabaseManager.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 23.01.2021.
//

import UIKit

class DatabaseManager {
    
    private let idsProvider = CitiesIdsProvider()
    var weatherData: [WeatherModel] = []
    
    static let shared = DatabaseManager()
    
    func fetchWeatherData(completion: (() -> Void)? = nil) {
        let citiesIDs = idsProvider.getIDs()
        
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

extension DatabaseManager {
    func addCityToFavourites(cityID: String, completion: (() -> Void)? = nil) {
        idsProvider.addID(id: cityID)
        fetchWeatherData() {
            completion?()
        }
    }
}

