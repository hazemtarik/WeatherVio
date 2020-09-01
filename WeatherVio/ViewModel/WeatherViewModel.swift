//
//  WeatherViewModel.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    
    // MARK:- Variables -
    var coreLocationEngine  : coreLocationEngineProtocol!
    var weatherVM           : CurrentViewModel? { didSet { reloadWeatherClosure?() }}
    var errorMessage        : String? { didSet { showErrorMessageClosure?() }}
    var locationMessage     : String? { didSet { showLocationMessageClosure?() }}
    
    var countOfDays         : Int { return weatherVM?.daily?.count ?? 0}
    
    var city                : String?
    var unit                : String? { return user_default.unit! }
    
    var reloadWeatherClosure: (()->())?
    var showErrorMessageClosure: (()->())?
    var showLocationMessageClosure: (()->())?
    
    
    
    
    init(coreLocationEngine: coreLocationEngineProtocol = CoreLocationEngine()) {
        self.coreLocationEngine = coreLocationEngine
    }
    
    
    
    
    // MARK:- Notification to validate if location request changed to Auth -
    private func notificationHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(initFetchWeather), name: NSNotification.Name(rawValue: notificationName.locationStatus), object: nil)
    }
    
    // MARK:- Configure Location auth protocol -
    private func locationAuthDelegate() {
        CoreLocationEngine.shared.delegate = self
    }
    
    
    
    // MARK:- Fetch weather data -
    @objc func initFetchWeather() {
        notificationHandling()
        locationAuthDelegate()
        coreLocationEngine.updateLocationClosure = { [weak self] in
            guard let self = self else { return }
            switch self.coreLocationEngine.locationResult {
                case .failure(let error): self.locationMessage = error.localizedDescription
                case .success(let location):
                    WeatherService.shared.fetchWeather(lat: location.latitude!, long: location.longitude!, unit: self.unit!) { [weak self] (result)  in
                        guard let self = self else { return }
                        switch result {
                            case .failure(let error): self.errorMessage = error.localizedDescription
                            case .success(let weather): self.weatherVM  = self.createCurrentVM(weather: weather, city: location.city!)
                        }
                }
                case .none:
                    return
            }
        }
        coreLocationEngine.FetchLocation() // Start to get location
    }
    
    
    func changeUnit(index: Int) {
        if index == 0 {
            UserDefaults.standard.setValue(units.Celsius.rawValue, forKey: userDefaultsKeys.unit)
        } else {
            UserDefaults.standard.setValue(units.Fahrenheit.rawValue, forKey: userDefaultsKeys.unit)
        }
    }
    
    
    
    
    // MARK:- Create weather view model -
    // Current
    private func createCurrentVM(weather: Weather, city: String) -> CurrentViewModel{
        let temp      = Int((weather.current?.temp)!)
        let min       = Int((weather.daily?.first?.temp?.min)!)
        let max       = Int((weather.daily?.first?.temp?.max)!)
        let pressure  = weather.current!.pressure!
        let humidity  = weather.current!.humidity!
        let unit      = self.unit == units.Celsius.rawValue ? 0 : 1
        let day       = weather.current!.dt!.convertToDay()
        let date      = weather.current!.dt!.convertToDate()
        let icon      = weather.current?.weather?.first?.icon
        let condation = weather.current?.weather?.first?.description
        let hourly    = createHourlyVM(hourly: weather.hourly!)
        let daily     = createDailyVM(daily: weather.daily!)
        
        return CurrentViewModel(temp: temp,
                                min: min,
                                max: max,
                                unit: unit,
                                pressure: pressure,
                                humidity: humidity,
                                city: city,
                                day: day, date: date,
                                icon: icon,
                                condation: condation,
                                hourly: hourly,
                                daily: daily)
    }
    
    //Hourly
    private func createHourlyVM(hourly: [current]) -> [HourlyViewModel] {
        var HVM = [HourlyViewModel]()
        for hour in hourly {
            var model = HourlyViewModel()
            model.temp = Int(hour.temp!)
            if hour.dt  == hourly.first?.dt {
                model.time = "Now"
            } else { model.time = hour.dt?.convertToTime() }
            model.icon = hour.weather?.first?.icon
            HVM.append(model)
        }
        return HVM
    }
    
    //Daily
    private func createDailyVM(daily: [daily]) -> [DailyViewModel] {
        var DVM = [DailyViewModel]()
        for day in daily {
            var model    = DailyViewModel()
            model.temp   = Int(day.temp!.day!)
            model.min    = Int(day.temp!.min!)
            model.max    = Int(day.temp!.max!)
            //let status   = day.weather?.first?.description
            if day.dt == daily.first?.dt {
                model.day = "Today"
            } else { model.day = "\(day.dt!.convertToDay())" }
            
            model.icon   = day.weather?.first?.icon
            DVM.append(model)
        }
        return DVM
    }
    
}




// MARK:- Location service auth handling -
extension WeatherViewModel: LocationAlertDelegate {
    func showMessage(message: String) {
        self.locationMessage = message
    }
    
    
}




// MARK:- Create Cells View Model. -

// Current
struct CurrentViewModel {
    var temp     : Int?
    var min      : Int?
    var max      : Int?
    var unit     : Int?
    var pressure : Int?
    var humidity : Int?
    var city     : String?
    var day      : String?
    var date     : String?
    var icon     : String?
    var condation: String?
    var hourly   : [HourlyViewModel]?
    var daily    : [DailyViewModel]?
}


// Hourly
struct HourlyViewModel {
    var temp     : Int?
    var time     : String?
    var icon     : String?
}


// Daily
struct DailyViewModel {
    var temp     : Int?
    var min      : Int?
    var max      : Int?
    var day      : String?
    var icon     : String?
}
