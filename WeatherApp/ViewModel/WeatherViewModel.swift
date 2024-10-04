//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    let client = APIManager()

    var stateView: StateView = StateView.loading {
        willSet {
            objectWillChange.send()
        }
    }

    var currentWeather = CurrentWeather.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }
    
    var todayWeather = ForecastWeather.emptyInit() {
        willSet {
            objectWillChange.send()
        }
    }

    var hourlyWeathers: [ForecastWeather] = [] {
        willSet {
            objectWillChange.send()
        }
    }

    var dailyWeathers: [ForecastWeather] = [] {
        willSet {
            objectWillChange.send()
        }
    }
    
    var currentDescription = "" {
        willSet {
            objectWillChange.send()
        }
    }
        
    private var stateCurrentWeather = StateView.loading
    private var stateForecastWeather = StateView.loading
    private let cityId = "1627459" // Serpong City Id

    // Latitude ve longitude için değişkenler
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    init() {
        // Başlangıçta bir varsayılan konumdan hava durumu verisini al
        getData(latitude: latitude, longitude: longitude)
    }
    
    func updateLocation(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        getData(latitude: latitude, longitude: longitude)
    }

    func retry() {
        stateView = .loading
        stateCurrentWeather = .loading
        stateForecastWeather = .loading

        getData(latitude: latitude, longitude: longitude)
    }

     func getData(latitude: Double, longitude: Double) {
        // Mevcut hava durumunu al
        client.getCurrentWeather(at: latitude, longitude: longitude) { [weak self] currentWeather, error in
            guard let ws = self else { return }
            
            if let currentWeather = currentWeather {
                ws.currentWeather = currentWeather
                ws.todayWeather = currentWeather.getForecastWeather()
                ws.currentDescription = currentWeather.description()
                ws.stateCurrentWeather = .success
            } else {
                ws.stateCurrentWeather = .failed
            }
            ws.updateStateView()
        }

        // Tahmin hava durumunu al
        client.getForecastWeather(at: latitude, longitude: longitude) { [weak self] forecastWeatherResponse, error in
            guard let ws = self else { return }
            
            if let forecastWeatherResponse = forecastWeatherResponse {
                ws.hourlyWeathers = forecastWeatherResponse.list
                ws.dailyWeathers = forecastWeatherResponse.dailyList
                ws.stateForecastWeather = .success
            } else {
                ws.stateForecastWeather = .failed
            }
            ws.updateStateView()
        }
    }

        
    func fetchWeatherForLocation(latitude: Double, longitude: Double) {
        client.getWeatherForCoordinates(latitude: latitude, longitude: longitude) { [weak self] currentWeather, error in
            guard let ws = self else { return }
            
            DispatchQueue.main.async {
                if let currentWeather = currentWeather {
                    printSuccess(currentWeather)
                    ws.currentWeather = currentWeather
                    ws.todayWeather = currentWeather.getForecastWeather()
                    ws.currentDescription = currentWeather.description()
                    ws.stateCurrentWeather = .success
                } else {
                    ws.stateCurrentWeather = .failed
                }
                ws.updateStateView()
            }
        }
    }


    func fetchWeatherForDefaultCity() {
        // Varsayılan şehir için enlem ve boylam değerlerini tanımlayın
        let defaultLatitude: Double =  -6.2592 // Örnek: Serpong, Endonezya için enlem
        let defaultLongitude: Double = 106.6463 // Örnek: Serpong, Endonezya için boylam

        client.getCurrentWeather(at: defaultLatitude, longitude: defaultLongitude) { [weak self] currentWeather, error in
            guard let ws = self else { return }
            if let currentWeather = currentWeather {
                printSuccess(currentWeather)
                ws.currentWeather = currentWeather
                ws.todayWeather = currentWeather.getForecastWeather()
                ws.currentDescription = currentWeather.description()
                ws.stateCurrentWeather = .success
            } else {
                ws.stateCurrentWeather = .failed
            }
            ws.updateStateView()
        }
    }


    private func updateStateView() {
        if stateCurrentWeather == .success && stateForecastWeather == .success {
            stateView = .success
        } else if stateCurrentWeather == .failed || stateForecastWeather == .failed {
            stateView = .failed
        }
    }
    func searchWeather(for city: String) {
        client.getCurrentWeatherwihtCity(at: city) { [weak self] currentWeather, error in
            guard let ws = self else { return }
            if let currentWeather = currentWeather {
                ws.currentWeather = currentWeather
                ws.todayWeather = currentWeather.getForecastWeather()
                ws.currentDescription = currentWeather.description()
                ws.stateCurrentWeather = .success
            } else {
                ws.stateCurrentWeather = .failed
            }
            ws.updateStateView()
        }
        // Tahmin hava durumunu al
        client.getForecastWeatherWithCity(at: city) { [weak self] forecastWeatherResponse, error in
            guard let ws = self else { return }
            
            if let forecastWeatherResponse = forecastWeatherResponse {
                ws.hourlyWeathers = forecastWeatherResponse.list
                ws.dailyWeathers = forecastWeatherResponse.dailyList
                ws.stateForecastWeather = .success
            } else {
                ws.stateForecastWeather = .failed
            }
            ws.updateStateView()
        }
    }

}
