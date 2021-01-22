//
//  CityCollectionViewCell.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 22.01.2021.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    static let id = "CityCollectionViewCell"
    
    @IBOutlet weak var backgroundImage: UIImageView?
    @IBOutlet weak var cityName: UILabel?
    @IBOutlet weak var temperature: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpViews()
    }
    
    private func setUpViews() {
        
    }
}
