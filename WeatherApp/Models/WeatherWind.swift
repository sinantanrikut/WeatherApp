//
//  WeatherWind.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import Foundation

struct WeatherWind: Codable {
    let speed: Double
    let deg: Int?
    
    static func emptyInit() -> WeatherWind {
        return WeatherWind(speed: 0.0, deg: nil)
    }
}
