//
//  NetworkEngine.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


class NetworkEngine {
    
    
    class func fetchData<T:Decodable>(serviceEndPoint: EndPoint, completion: @escaping(Result<T,ErrorHandler>)->()) {
        var components = URLComponents()
        
        components.scheme     = serviceEndPoint.scheme
        components.host       = serviceEndPoint.base
        components.path       = serviceEndPoint.path
        components.queryItems = serviceEndPoint.parametar
        
        guard let urlString   = components.url else { return }
        var url = URLRequest(url: urlString)
        url.httpMethod = serviceEndPoint.method
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handling Error
            if let error = error as NSError? {
                guard error.code != -1009 else {
                    completion(.failure(.offline))
                    return
                }
            }
            
            // Response validation
            guard let urlResponse = response as! HTTPURLResponse? else {
                completion(.failure(.requestFailed))
                return
            }
            guard urlResponse.statusCode >= 200 && urlResponse.statusCode < 2999 else {
                completion(.failure(.responseUnsuccessful))
                return
            }
            
            // Data validation
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            
            // Decode weather data
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.error(error: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
