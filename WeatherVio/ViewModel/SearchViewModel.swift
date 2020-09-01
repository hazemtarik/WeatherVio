//
//  SearchViewModel.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/22/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation


class SearchViewModel {
    
    
    // MARK: - Variables -
    let cityService     : cityServiceProtocol!
    var resultVM        : [ResultViewModel]? { didSet { updateTableViewClosure?() }}
    var countOfCells    : Int? { return resultVM?.count }
    
    var updateTableViewClosure: (()->())?
    
    
    init(cityService: cityServiceProtocol = CityService()) {
        self.cityService = cityService
    }
    
    
    
    
    // MARK: - Functions -
    
    // Start search about city from here.
    func beginSearch(city: String) {
        cityService.fetchCity(city: city) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
                case .success(let city):
                    self.resultVM = self.processViewModel(cities: city)
                case .failure(_):
                    self.resultVM?.removeAll()
            }
        }
    }
    
    // Proccess to convert data from api to model
    private func processViewModel(cities: City) -> [ResultViewModel]{
        guard let results = cities.results else { return [ResultViewModel]()}
        let locations = results[0].locations
        var addresses = [ResultViewModel]()
        for location in locations! {
            addresses.append(self.createResultViewModel(address: location))
        }
        return addresses
    }
    
    // Create the cell view model
    private func createResultViewModel(address: location) -> ResultViewModel {
        let street       = address.street  == "" ? "" : address.street! + ", "
        let city         = address.city    == "" ? "" : address.city! + ", "
        let country      = address.country == "" ? "" : address.country!
        let lat          = address.coord?.lat
        let lon          = address.coord?.lng
        let finalAddress = street + city + country
        return .init(address: finalAddress, lat: lat, lon: lon)
        
    }
    
    // Insert data of selected city to coreData
    func selectedCell(row: Int) {
        CoreDataEngine.shared.saveCity(cityVM: resultVM![row])
    }
    
}






// MARK:- Result view model of cell -

struct ResultViewModel {
    var address : String?
    var lat     : Double?
    var lon     : Double?
}
