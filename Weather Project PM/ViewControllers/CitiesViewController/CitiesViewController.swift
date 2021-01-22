//
//  ViewController.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet weak var citiesCollectionView: UICollectionView?
    
    private let citiesCollectionViewDataSource: CitiesCollectionViewDataSource = CitiesCollectionViewDataSource()
    private let citiesCollectionViewDelegate: CitiesCollectionViewDelegateFlowLayout = CitiesCollectionViewDelegateFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let citiesCollectionView = citiesCollectionView else { return }
        
        citiesCollectionView.dataSource = citiesCollectionViewDataSource
        citiesCollectionView.delegate = citiesCollectionViewDelegate
        citiesCollectionView.register(UINib(nibName: CityCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: CityCollectionViewCell.id)
        
    }
}

