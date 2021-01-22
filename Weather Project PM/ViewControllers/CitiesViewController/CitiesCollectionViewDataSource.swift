//
//  CitiesCollectionViewDataSource.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class CitiesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    let data: [Int] = [0, 1]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.id, for: indexPath)
        
        return cell
    }
    
    
}
