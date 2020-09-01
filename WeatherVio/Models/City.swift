//
//  City.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/21/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

// MARK: - City Model which saved in coreData -

struct CityDB {
    var city    : String?
    var lat     : Double?
    var lon     : Double?
}




// MARK: - City Model which get from API -

struct City: Decodable {
    var results : [locations]?
}

struct locations: Decodable {
    var locations : [location]?
}


struct location: Decodable {
    var street     : String?
    var city       : String?
    var country    : String?
    var coord      : coord?
    enum CodingKeys: String, CodingKey {
        case street
        case city    = "adminArea5"
        case country = "adminArea1"
        case coord   = "latLng"
    }
    
}

struct coord: Decodable {
    var lat : Double?
    var lng : Double?
}
