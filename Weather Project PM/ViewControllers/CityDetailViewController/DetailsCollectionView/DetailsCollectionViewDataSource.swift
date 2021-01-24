//
//  DetailsCollectionViewDataSource.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class DetailsCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var details: [DetailsModel] = []
    
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
