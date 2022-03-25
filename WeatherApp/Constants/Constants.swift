//
//  Constants.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 25.03.2022.
//

import Foundation

let FIRS_TO_MAIN = "firsttomain"




let BASE_URL = "https://api.openweathermap.org/data/2.5/"
let WEATHER = "weather?"
let LAT = "lat="
let LON = "&lon="
let APP_ID = "&appid="
let API_KEY = "2f11a4bac82f5c8ef4af0b4811e414e9"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER)\(LAT)39.971205\(LON)32.704476\(APP_ID)\(API_KEY)"
