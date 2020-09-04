//
//  ColorCollectionViewCell.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/30/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIViewX!
    @IBOutlet weak var selectedView: UIViewX!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectedView.layer.borderWidth = 1
        selectedView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func setupColorView(named: String, selectedColor: String?) {
        colorView.backgroundColor = UIColor(named: named)
        if named == selectedColor {
            selectedView.backgroundColor = .white
        } else {
            selectedView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.196791524)
        }
    }
    
}
