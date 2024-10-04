//
//  APIManager.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation
import Combine
import SwiftUI

final class APIManager {
    
    public static let shared = APIManager()
    
    private var showLoading = true
       
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, Error?) -> Void
    typealias ForecastWeatherCompletionHandler = (ForecastWeatherResponse?, Error?) -> Void

    private let apiKey = "9443786f946d0de25ec663f26e82c537"
    private let decoder = JSONDecoder()
    private let session: URLSession

    private enum SuffixURL: String {
        case forecastWeather = "forecast"
        case currentWeather = "weather"
    }
        
    private func baseUrl(_ suffixURL: SuffixURL, param: String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/\(suffixURL.rawValue)?APPID=\(self.apiKey)&units=metric\(param)")!
    }
        
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
        
    private func getBaseRequest<T: Codable>(at cityId: String,
                                            suffixURL: SuffixURL,
                                            completionHandler completion:  @escaping (_ object: T?,_ error: Error?) -> ()) {
        
        let url = baseUrl(suffixURL, param: "&id=\(cityId)")
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        printError(response ?? "e")
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(T.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        printError(response ?? "e")
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    func getCurrentWeather(at latitude: Double, longitude: Double, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(self.apiKey)&units=metric")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        completion(nil, error)
                        return
                    }
                    
                    do {
                        let weather = try self.decoder.decode(CurrentWeather.self, from: data)
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }

    func getForecastWeather(at latitude: Double, longitude: Double, completionHandler completion: @escaping ForecastWeatherCompletionHandler) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&APPID=\(self.apiKey)&units=metric")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        completion(nil, error)
                        return
                    }
                    
                    do {
                        let forecast = try self.decoder.decode(ForecastWeatherResponse.self, from: data)
                        completion(forecast, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }

    func getWeatherForCoordinates(latitude: Double, longitude: Double, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(self.apiKey)&units=metric")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        completion(nil, error)
                        return
                    }
                    
                    do {
                        let weather = try self.decoder.decode(CurrentWeather.self, from: data)
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    func getCurrentWeatherwihtCity(at city: String, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        // Şehir adı kullanarak URL oluşturma
        let url = baseUrl(.currentWeather, param: "&q=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        printError(response ?? "e")
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(CurrentWeather.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        printError(response ?? "e")
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    func getForecastWeatherWithCity(at city: String, completionHandler completion: @escaping ForecastWeatherCompletionHandler) {
        // Şehir adı kullanarak URL oluşturma
        let url = baseUrl(.forecastWeather, param: "&q=\(city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        printError(response ?? "e")
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let forecastResponse = try self.decoder.decode(ForecastWeatherResponse.self, from: data)
                            completion(forecastResponse, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        printError(response ?? "e")
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }

}
