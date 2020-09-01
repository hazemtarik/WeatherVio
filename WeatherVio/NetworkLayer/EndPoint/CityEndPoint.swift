//
//  CityEndPoint.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/30/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


private let cityAPPKey   = ""



// MARK:- Configure URL in different cases -

enum CityEndPoint: EndPoint {
    case SearchCity(city: String)
}



extension CityEndPoint {
    var scheme: String {
        switch self {
            default:
                return "https"
        }
    }
    var base: String {
        switch self {
            default:
                return "www.mapquestapi.com"
        }
    }
    var path: String {
        switch self {
            default:
                return "/geocoding//v1/address"
        }
    }
    var method: String {
        switch self {
            default:
                return "GET"
        }
    }
    var parametar: [URLQueryItem] {
        switch self {
            
            case .SearchCity(let city):
                return [
                    URLQueryItem(name: "location", value: city),
                    URLQueryItem(name: "key", value: cityAPPKey)
            ]
        }
    }
    
}
