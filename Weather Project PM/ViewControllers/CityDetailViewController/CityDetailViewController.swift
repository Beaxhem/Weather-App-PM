//
//  CityDetailViewController.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 23.01.2021.
//

import UIKit

class CityDetailViewController: UIViewController {
    var cellHeight: CGFloat = 50
    
    var weatherModel: WeatherModel?
    var details: [DetailsModel] = []
    
    @IBOutlet weak var weatherTitleLabel: UILabel?
    @IBOutlet weak var cityNameLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var minTempLabel: UILabel?
    @IBOutlet weak var maxTempLabel: UILabel?
    @IBOutlet weak var forecastCollectionView: UICollectionView?
    @IBOutlet weak var detailsCollectionView: UICollectionView?
    
    private let forecastDataSource = ForecastCollectionViewDataSource()
    private let forecaseDelegate = ForecastCollectionViewDelegate()
    
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
        
        details = [
            DetailsModel(title: "Sunrise", value: "\(dateFormatter.string(from: sunriseDate))"),
            DetailsModel(title: "Sunset", value: "\(dateFormatter.string(from: sunsetDate))"),
            DetailsModel(title: "Humidity", value: "\(weatherModel.main.humidity)%"),
            DetailsModel(title: "Wind", value: "\(weatherModel.wind.direction) \(weatherModel.wind.speed) km/h"),
            DetailsModel(title: "Feels like", value: tempFormatter.string(temp: weatherModel.main.feelsLike))
        ]
        
        detailsCollectionView?.dataSource = self
        detailsCollectionView?.delegate = self
        detailsCollectionView?.register(UINib(nibName: DetailCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: DetailCollectionViewCell.id)
    }
    
    func loadForecast() {
        guard let weatherModel = weatherModel else {
            return
        }
        
        DispatchQueue.main.async {
            WeatherManager.shared.loadWeatherPrediction(by: weatherModel) {[weak self] (res) in
                switch res {
                case .failure(let error):
                    print(error)
                case .success(let predictionQuery):
                    print(predictionQuery)
                    self?.forecastDataSource.predictions = predictionQuery.daily
                    self?.forecastCollectionView?.reloadData()
                }
            }
        }
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension CityDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: -UICollectionViewDataSource
extension CityDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.id, for: indexPath) as? DetailCollectionViewCell else {
            fatalError()
        }
        
        let detail = details[indexPath.item]
        cell.configure(with: detail)
        
        return cell
    }
}
