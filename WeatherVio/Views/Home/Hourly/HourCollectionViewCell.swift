//
//  HourCollectionViewCell.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    // MARK:- Variables -
    var hourVM = HourlyViewModel() { didSet {
        setupUI()
        timeLabel.text = hourVM.time
        statusImage.image = UIImage(named: hourVM.icon!)
        tempLabel.text = "\(hourVM.temp!)º"
        }}
    
    
    // MARK:- Outlets -
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cardView: UIViewX!
    
    
    private func setupUI() {
        let color = UIColor(named: user_default.color!)
        cardView.backgroundColor = color
    }
    
}
