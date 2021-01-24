//
//  ForecastCollectionViewDelegate.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class ForecastCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let cellWidth: CGFloat = 100
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cellWidth, height: collectionView.frame.height)
    }
}
