//
//  DayCollectionViewCell.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    
    // MARK:- Variables -
    var dayVM = DailyViewModel() { didSet {
        setupUI()
        dayLabel.text     = dayVM.day!
        statusImage.image = UIImage(named: dayVM.icon!)
        tempLabel.text    = "\(dayVM.temp!)º"
        minLabel.text     = "\(dayVM.min!)º"
        maxLabel.text     = "\(dayVM.max!)º"
        }}
    
    
    // MARK:- Outlets -
    @IBOutlet weak var cardView: UIViewX!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    
    
    private func setupUI() {
        let color = UIColor(named: user_default.color!)
        cardView.backgroundColor = color
    }
    
}
