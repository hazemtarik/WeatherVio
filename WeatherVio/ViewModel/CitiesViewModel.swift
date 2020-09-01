//
//  CitiesViewModel.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/22/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


class CitiesViewModel {
    
    // MARK: - Variables -
    var cityVM          : [CityViewModel]? { didSet { reloadCollectionViewClosure?() }}
    var countOfCells    : Int? { return cityVM?.count}
    let coreDataEngine : coreDataEngineProtocol!
    
    var reloadCollectionViewClosure: (()->())?
    
    
    init(coreDataEngine: coreDataEngineProtocol = CoreDataEngine()) {
        self.coreDataEngine = coreDataEngine
    }
    
    
    
    
    
    
    // MARK: - Functions -
    
    // Fetch saved cities from coreData
    func fetchSavedCities() {
        coreDataEngine.FetchCitiesCoreData { [weak self] (cities) in
            guard let self = self else { return }
            guard let cities = cities else { return }
            self.fetchWeather(cities: cities)
        }
    }
    
    // Fetch weather data for cities from API
    private func fetchWeather(cities: [CityDB]) {
        let unit = user_default.unit
        var weathers = [SavedWeather]()
        var counter = 1
        for city in cities {
            WeatherService.shared.fetchSavedWeather(lat: city.lat!, long: city.lon!, unit: unit!) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                    case .success(var weather):
                        weather.main?.city = city.city
                        weathers.append(weather)
                        if counter == cities.count { self.processViewModel(weathers: weathers) }
                    counter += 1
                    case .failure(_): break
                }
            }
        }
    }
    
    // Proccess to convert data from api to model
    private func processViewModel(weathers: [SavedWeather]) {
        var citiesVM = [CityViewModel]()
        for weather in weathers {
            citiesVM.append(self.createCurrentVM(weather: weather))
        }
        cityVM = citiesVM.sorted(by: { $0.temp! > $1.temp! } )
    }
    
    private func createCurrentVM(weather: SavedWeather) -> CityViewModel{
        let temp      = Int((weather.main?.temp)!)
        let min       = Int((weather.main?.temp_min)!)
        let max       = Int((weather.main?.temp_max)!)
        let pressure  = weather.main!.pressure!
        let humidity  = weather.main!.humidity!
        let city      = weather.main!.city!
        let icon      = weather.weather!.first!.icon!
        let condation = weather.weather!.first!.description!
        return .init(temp: temp,
                     min: min,
                     max: max,
                     pressure: pressure,
                     humidity: humidity,
                     city: city,
                     icon: icon,
                     condation: condation)
    }
    
    
    // Detect which city selected to delete from coreData
    func deleteCityFromCoreData(row: Int) {
        guard let city = cityVM?[row].city else { return }
        CoreDataEngine.shared.DeleteCity(city: city) { [weak self] (isDeleted) in
            guard let self = self else { return }
            switch isDeleted {
                case true:
                    self.cityVM?.remove(at: row)
                case false:
                print("No")
            }
        }
    }
    
}




struct CityViewModel {
    var temp      : Int?
    var min       : Int?
    var max       : Int?
    var pressure  : Int?
    var humidity  : Int?
    var city      : String?
    var icon      : String?
    var condation : String?
}
