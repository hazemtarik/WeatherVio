//
//  Weather.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/19/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

// MARK: - Current Weather Model get from API  -

struct Weather: Decodable {
    var current     : current?
    var hourly      : [current]?
    var daily       : [daily]?
}

// Current and Hourly
struct current: Decodable {
    var dt          : Int?
    var temp        : Double?
    var feels_like  : Double?
    var pressure    : Int?
    var humidity    : Int?
    var wind_speed  : Double?
    var weather     : [weather]?
}

// Daily
struct daily: Decodable {
    var dt          : Int?
    var temp        : temp?
    var pressure    : Int?
    var humidity    : Int?
    var wind_speed  : Double?
    var weather     : [weather]?
}

// Weather description
struct weather: Decodable {
    var main        : String?
    var description : String?
    var icon        : String?
}

// Temp in details
struct temp: Decodable {
    var min         : Double?
    var max         : Double?
    var day         : Double?
}

