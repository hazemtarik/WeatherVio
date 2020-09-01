//
//  EndPointProtocol.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

// MARK:- Responsability: Work for configure URL componentes -

protocol EndPoint {
    var scheme      : String {get}
    var base        : String {get}
    var path        : String {get}
    var method      : String {get}
    var parametar   : [URLQueryItem] {get}
}
