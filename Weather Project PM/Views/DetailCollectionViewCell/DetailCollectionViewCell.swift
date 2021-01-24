//
//  CityCollectionViewCell.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    static let id = "DetailCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?
    
    func configure(with detail: DetailsModel) {
        titleLabel?.text = detail.title
        valueLabel?.text = detail.value
    }
}
