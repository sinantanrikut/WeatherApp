//
//  Coordinate.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import Foundation

struct Coordinate: Codable {
    let lon, lat: Double
    
    static func emptyInit() -> Coordinate {
        return Coordinate(lon: 0, lat: 0)
    }
}
