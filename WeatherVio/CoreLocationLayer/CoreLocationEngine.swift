//
//  CoreLocationEngine.swift
//  WeatherVio
//
//  Created by Hazem Tarek on 8/20/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import Foundation
import CoreLocation


// MARK:- A protocol to pass authorization validation message to view model. -
protocol LocationAlertDelegate {
    func showMessage(message: String)
}

protocol coreLocationEngineProtocol {
    /// The main funcation to start the CoreLocation Engine.
    func FetchLocation()
    var locationResult: Result<Location,ErrorHandler>? { get }
    var updateLocationClosure: (()->())? { get set }
}




// MARK:- Responsability: Detect the current location and city name. -
class CoreLocationEngine: NSObject, coreLocationEngineProtocol {
    
    
    
    // MARK:- Variables -
    public static let shared    = CoreLocationEngine() // Instance.
    
    private let locationManager = CLLocationManager()
    private let geoCoder        = CLGeocoder()
    private let currentLocation = CLLocation()
    
    public var delegate: LocationAlertDelegate? // Delegate of location alert protocol.
    public private(set) var locationResult: Result<Location,ErrorHandler>? {
        didSet {updateLocationClosure?()}} // Fire the closure when detect Updated Location.
    
    var updateLocationClosure: (()->())? // Closure.
    
    
    
    
    
    // MARK:- Functions -
    // Configure Location Manager
    private func locationManagerConfigruation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationAuthValidation()
    }
    
    // Location authorization validation
    private func locationAuthValidation() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                break
            case .denied:
                self.delegate?.showMessage(message: "We need access to your location to display the weather.")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                self.delegate?.showMessage(message: "We need access to your location to display the weather.")
            @unknown default:
                break
        }
    }
    
    
    func FetchLocation() {
        locationManagerConfigruation()
        guard let location = locationManager.location  else {
            locationManager.requestLocation()
            return }
        createLocationModel(location: location) { (result) in
            self.locationResult = result
        }
    }
    
    // Detect the city name based on current location and create Location Model
    private func createLocationModel(location: CLLocation, completion: @escaping(Result<Location, ErrorHandler>) -> Void) {
        geoCoder.reverseGeocodeLocation(location) { (placeMark, error) in
            guard let placeMark = placeMark else {
                completion(.failure(.offline))
                return  }
            placeMark.forEach { (place) in
                var locat = Location()
                locat.country   = place.country
                locat.city      = "\(place.locality!), \(place.country!)"
                locat.latitude  = location.coordinate.latitude
                locat.longitude = location.coordinate.longitude
                completion(.success(locat))
            }
        }
    }
    
}




// MARK:- Location Manager Delegate -

extension CoreLocationEngine: CLLocationManagerDelegate {
    // Update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            delegate?.showMessage(message: "We cannot get your location.")
            return
        }
        createLocationModel(location: location) { (result) in
            self.locationResult = result
        }
    }
    
    // Check if Authorization status is changed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName.locationStatus), object: nil) // Fire The Notification if user accept the authrization
            case .denied:
                self.delegate?.showMessage(message: "We need access your location to display the weather.")
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted:
                self.delegate?.showMessage(message: "We need access your location to display the weather.")
            @unknown default:
                break
        }
    }
    
    // Update error message if the propblem happen when detect current location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
}

