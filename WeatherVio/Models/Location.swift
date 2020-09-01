//
//  Location.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

// MARK: - Location Model which get from CLLocationManager -

struct Location {
    var latitude  : Double?
    var longitude : Double?
    var city      : String?
    var country   : String?
}
