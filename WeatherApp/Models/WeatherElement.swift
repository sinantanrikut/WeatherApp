//
//  WeatherElement.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 4.10.2024.
//

import Foundation

struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    static func emptyInit() -> WeatherElement {
        return WeatherElement(
            id: 0,
            main: "",
            weatherDescription: "",
            icon: ""
        )
    }
}
