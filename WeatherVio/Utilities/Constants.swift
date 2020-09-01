//
//  Constants.swift
//  WeaterVio
//
//  Created by Hazem Tarek on 8/19/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

struct cells {
    // Cells Identifiers
    static let current = "currentCell"
    static let hourly  = "hourlyCell"
    static let daily   = "dailyCell"
    static let city    = "cityCell"
    static let addCity = "addedCityCell"
    static let colors  = "colorCell"
    
    // Section Identifiers
    static let header  = "headerSection"
}


struct notificationName {
    static let locationStatus = "didAuthorized"
    static let changeColor    = "changeColor"
}


struct imagesName {
    static let locationAuth  = "Auth"
    static let noInernet     = "Internet"
    static let somthingWrong = "Wrong"
}


struct coreData {
    static let entity = "Cities"
}

struct stroryBoard {
    static let settings = "settings"
}

struct userDefaultsKeys {
    static let unit  = "unit"
    static let color = "color"
}
