//
//  SavedWeather.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/22/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

// MARK: - Current weather model for saved cities -

struct SavedWeather: Decodable {
    var weather : [weather]?
    var main    : main?
}


struct main: Decodable {
    var temp       : Double?
    var temp_min   : Double?
    var temp_max   : Double?
    var pressure   : Int?
    var humidity   : Int?
    var city       : String?
}
