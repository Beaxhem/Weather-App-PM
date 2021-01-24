//
//  ViewController.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class CitiesViewController: UIViewController {
    
    private let cellHeight: CGFloat = 100
    var database: DatabaseManager = DatabaseManager.shared
    
    @IBOutlet weak var citiesCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let citiesCollectionView = citiesCollectionView else { return }
        
        citiesCollectionView.dataSource = self
        citiesCollectionView.delegate = self
        citiesCollectionView.register(UINib(nibName: CityCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: CityCollectionViewCell.id)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonPressed))
        
        fetchData()     
    }
    
    @objc private func addButtonPressed() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") else { return }
        
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    private func fetchData() {
        DatabaseManager.shared.fetchWeatherData { [weak self] in
            self?.citiesCollectionView?.reloadData()
        }
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension CitiesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "CityDetailViewController") as? CityDetailViewController else {
            return
        }
        
        vc.weatherModel = database.weatherData[indexPath.item]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -UICollectionViewDataSource
extension CitiesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return database.weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.id, for: indexPath) as? CityCollectionViewCell else {
            fatalError()
        }
        
        let weather = database.weatherData[indexPath.item]
        cell.configure(with: weather)
        
        return cell
    }
}
