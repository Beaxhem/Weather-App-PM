//
//  DetailsCollectionViewDelegateFlowLayout.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 24.01.2021.
//

import UIKit

class DetailsCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    var cellHeight: CGFloat = 50
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
