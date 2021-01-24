//
//  WeatherNetworkManager.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import Foundation

protocol WeatherNetworkManager {
    func loadCurrentWeather(byCityname city: String, completion: @escaping(Result<WeatherModel, Error>) -> Void)
    func loadCurrentWeatherForMultipleCities(citiesIDs: [String], completion: @escaping (Result<[WeatherModel], Error>) -> Void)
}

class WeatherManager: WeatherNetworkManager {
    static let shared = WeatherManager()
    
    var networkService: Networking
    var urlProvider: URLProvider
    var jsonDecoder = JSONDecoder()
    
    init(networkService: Networking = URLSessionNetworkService(), urlProvider: URLProvider = OpenWeatherURLProvider()) {
        self.networkService = networkService
        self.urlProvider = urlProvider
    }
    
    func loadCurrentWeatherForMultipleCities(citiesIDs: [String], completion: @escaping (Result<[WeatherModel], Error>) -> Void) {
        guard let url = urlProvider.getCurrentWeatherLinkForMultipleCities(citiesIDs: citiesIDs) else {
            return
        }
        
        networkService.dataTask(with: url) { [weak self] (res) in
            guard let self = self else { return }
            switch res {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let weatherData = try self.jsonDecoder.decode(MultipleCitiesQuery.self, from: data)
                    completion(.success(weatherData.list))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadWeatherPrediction(by weather: WeatherModel, completion: @escaping(Result<PredictionQuery, Error>) -> Void) {
        guard let url = urlProvider.getWeatherPredictionLink(with: weather.coord) else {
            return
        }
        
        networkService.dataTask(with: url) { [weak self] (res) in
            guard let self = self else { return }
            
            switch res {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let prediction = try self.jsonDecoder.decode(PredictionQuery.self, from: data)
                    completion(.success(prediction))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func loadCurrentWeather(byCityname city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        guard let url = urlProvider.getCurrentWeatherLink(cityName: city) else {
            return
        }
        
        networkService.dataTask(with: url) { [weak self] (res) in
            guard let self = self else { return }
            switch res {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let weather = try self.jsonDecoder.decode(WeatherModel.self, from: data)
                    
                    completion(.success(weather))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
