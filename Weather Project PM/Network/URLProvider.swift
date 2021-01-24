//
//  URLProvider.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 23.01.2021.
//

import Foundation

protocol URLProvider {
    func getCurrentWeatherLink(cityName: String) -> URL?
    func getCurrentWeatherLinkForMultipleCities(citiesIDs: [String]) -> URL?
    func getWeatherPredictionLink(with coords: Coords) -> URL?
}

class OpenWeatherURLProvider: URLProvider {
    private let apiKey = Secrets.openWeatherAPIKey
    
    func getCurrentWeatherLink(cityName: String) -> URL? {
        let api = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)"
        
        return encodeURL(rawURL: api)
    }
    
    func getCurrentWeatherLinkForMultipleCities(citiesIDs: [String]) -> URL? {
        let api = "https://api.openweathermap.org/data/2.5/group?id=\(citiesIDs.joined(separator: ","))&units=metric&appid=\(apiKey)"
        
        return encodeURL(rawURL: api)
    }
    
    func getWeatherPredictionLink(with coords: Coords) -> URL? {
        let api = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coords.lat)&lon=\(coords.lon)&exclude=current,minutely,hourly,alerts&appid=\(apiKey)&units=metric"
        
        return encodeURL(rawURL: api)
    }
    
    func encodeURL(rawURL: String) -> URL? {
        guard let encodedURL = rawURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return URL(string: encodedURL)
    }
}

