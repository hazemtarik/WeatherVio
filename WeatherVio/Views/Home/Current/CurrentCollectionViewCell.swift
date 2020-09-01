//
//  CurrentCollectionViewCell.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class CurrentCollectionViewCell: UICollectionViewCell {
    
    
    // MARK:- Outlets -
    @IBOutlet weak var cardView: UIViewX!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var unitSegment: UISegmentedControl!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var minAndMaxLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    
    // MARK:- Flow -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    // MARK:- Funcations -
    private func setupUI() {
        let color = UIColor(named: user_default.color!)
        cardView.backgroundColor = color
        todayLabel.textColor     = color
        menuButton.tintColor     = color
    }
    
    func current(date: String, temp: String, condition: String, icon: String, minAndMax: String, city: String, unit: Int, pressure: String, humidity: String) {
        setupUI()
        dateLabel.text = date
        tempLabel.text = temp
        conditionLabel.text = condition
        statusImage.image = UIImage(named: icon)
        minAndMaxLabel.text = minAndMax
        unitSegment.selectedSegmentIndex = unit
        countryLabel.text = city
        pressureLabel.text = pressure
        humidityLabel.text = humidity
    }
    
}
