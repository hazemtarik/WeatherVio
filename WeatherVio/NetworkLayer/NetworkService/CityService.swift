//
//  CityService.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 9/1/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


protocol cityServiceProtocol {
    func fetchCity(city: String, completion: @escaping(Result<City,ErrorHandler>)->())
}



class CityService: cityServiceProtocol {
    func fetchCity(city: String, completion: @escaping(Result<City,ErrorHandler>)->()) {
        NetworkEngine.fetchData(serviceEndPoint: CityEndPoint.SearchCity(city: city)) { (result) in
            completion(result)
        }
    }
}
