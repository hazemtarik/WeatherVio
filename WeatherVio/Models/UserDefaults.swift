//
//  UserDefaults.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/30/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


// MARK: - Defaults -

struct user_default {
    static private let defualts = UserDefaults.standard
    
    static var unit  : String? { return defualts.string(forKey: "unit")  }
    static var color : String? { return defualts.string(forKey: "color") ?? "0" }
}
