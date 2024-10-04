//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private var locationManager = CLLocationManager()
    
    // Optional CLLocationCoordinate2D
    @Published var location: CLLocationCoordinate2D? // Bu değişken konumu tutacak
    
    // WeatherViewModel'i burada tanımlayın
    var weatherViewModel: WeatherViewModel?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation.coordinate
        
        // Hava durumu almak için güncellenen konumu kullan
        // weatherViewModel'i burada kontrol edin
        weatherViewModel?.fetchWeatherForLocation(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        weatherViewModel?.updateLocation(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        printSuccess(newLocation.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    func requestLocation() {
        locationManager.requestLocation()
    }
}
