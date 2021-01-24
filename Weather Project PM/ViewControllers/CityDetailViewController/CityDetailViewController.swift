//
//  CityDetailViewController.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 23.01.2021.
//

import UIKit

class CityDetailViewController: UIViewController {
    
    
    var weatherModel: WeatherModel?
    
    
    @IBOutlet weak var weatherTitleLabel: UILabel?
    @IBOutlet weak var cityNameLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var minTempLabel: UILabel?
    @IBOutlet weak var maxTempLabel: UILabel?
    @IBOutlet weak var forecastCollectionView: UICollectionView?
    @IBOutlet weak var detailsCollectionView: UICollectionView?
    
    private let forecastDataSource = ForecastCollectionViewDataSource()
    private let forecaseDelegate = ForecastCollectionViewDelegate()
    
    private let detailsDataSource = DetailsCollectionViewDataSource()
    private let detailsDelegate = DetailsCollectionViewDelegateFlowLayout()
    
    private let tempFormatter = RoundTemperatureFormatter()
    private let dateFormatter = HoursDateFormatter()
    
    override func viewDidLoad() {
        guard let weatherModel = weatherModel else {
            return
        }
        
        weatherTitleLabel?.text = weatherModel.weather[0].title
        temperatureLabel?.text = tempFormatter.string(temp: weatherModel.main.currentTemp)
        cityNameLabel?.text = weatherModel.name
        minTempLabel?.text = "from \(tempFormatter.string(temp: weatherModel.main.minTemp))"
        maxTempLabel?.text = "to \(tempFormatter.string(temp: weatherModel.main.maxTemp))"
        
        setUpForecastView()
        setUpDetailsView()
        loadForecast()
    }
    
    func setUpForecastView() {
        forecastCollectionView?.dataSource = forecastDataSource
        forecastCollectionView?.delegate = forecaseDelegate
        forecastCollectionView?.register(UINib(nibName: ForecastCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: ForecastCollectionViewCell.id)
    }
    
    func setUpDetailsView() {
        guard let weatherModel = weatherModel else {
            return
        }
        
        let sys = weatherModel.sys

        let sunriseDate = Date(timeIntervalSince1970: Double(sys.sunrise))
        let sunsetDate = Date(timeIntervalSince1970: Double(sys.sunset))
        
        detailsDataSource.details = [
            DetailsModel(title: "Sunrise", value: "\(dateFormatter.string(from: sunriseDate))"),
            DetailsModel(title: "Sunset", value: "\(dateFormatter.string(from: sunsetDate))"),
            DetailsModel(title: "Humidity", value: "\(weatherModel.main.humidity)%"),
            DetailsModel(title: "Wind", value: "\(weatherModel.wind.direction) \(weatherModel.wind.speed) km/h"),
            DetailsModel(title: "Feels like", value: tempFormatter.string(temp: weatherModel.main.feelsLike))
        ]
        
        detailsCollectionView?.dataSource = detailsDataSource
        detailsCollectionView?.delegate = detailsDelegate
        detailsCollectionView?.register(UINib(nibName: DetailCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.id)
    }
    
    func loadForecast() {
        guard let weatherModel = weatherModel else {
            return
        }
        
        WeatherManager.shared.loadWeatherPrediction(by: weatherModel) {[weak self] (res) in
            switch res {
            case .failure(let error):
                print(error)
            case .success(let predictionQuery):
                self?.forecastDataSource.predictions = predictionQuery.daily
                self?.forecastCollectionView?.reloadData()
            }
        }
    }
}
