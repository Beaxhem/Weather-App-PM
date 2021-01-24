//
//  ForecastCollectionViewDataSource.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class ForecastCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var predictions: [Prediction] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        predictions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.id, for: indexPath) as? ForecastCollectionViewCell else {
            fatalError()
        }
        
        let prediction = predictions[indexPath.item]
        cell.configure(with: prediction)
        
        return cell
    }
    
    
}
