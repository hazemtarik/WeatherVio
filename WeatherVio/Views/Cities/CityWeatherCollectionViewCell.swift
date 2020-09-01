//
//  CityWeatherCollectionViewCell.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/22/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

class CityWeatherCollectionViewCell: UICollectionViewCell {
    
    
    // MARK:- Outlets -
    @IBOutlet weak var cardView: UIViewX!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var minAndMaxLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    
    // MARK:- Flow -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
    // MARK:- Funcations -
    private func setupUI() {
        let color = UIColor(named: user_default.color!)
        cardView.backgroundColor = color
    }
    
    
    func current(temp: String, condition: String, icon: String, minAndMax: String, city: String, pressure: String, humidity: String) {
        setupUI()
        tempLabel.text = temp
        conditionLabel.text = condition
        statusImage.image = UIImage(named: icon)
        minAndMaxLabel.text = minAndMax
        countryLabel.text = city
        pressureLabel.text = pressure
        humidityLabel.text = humidity
    }
    
    func setDeleteButton(tag: Int,target: Any?, action: Selector) {
        deleteButton.tag = tag
        deleteButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
