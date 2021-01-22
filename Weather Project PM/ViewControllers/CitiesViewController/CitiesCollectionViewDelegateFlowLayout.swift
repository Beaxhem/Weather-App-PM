//
//  CitiesCollectionViewFlowDelegate.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class CitiesCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let cellHeight: CGFloat = 100
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
}
