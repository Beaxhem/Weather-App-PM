//
//  UIView.swift
//  Weather Project PM
//
//  Created by Ilya Senchukov on 23.01.2021.
//

import UIKit

extension UIView {
    func addBottomBorder() {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        border.backgroundColor = UIColor.gray.cgColor
        layer.addSublayer(border)
    }
}
