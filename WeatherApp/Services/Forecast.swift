//
//  Forecast.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 26.03.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class Forecast{
    var _date:String!
    var _weatherType:String!
    var _highTemp:String!
    var _lowTemp:String!
    
    // Her obje için tek referans olması için hiçbir zaman kendini çoklamaz
    static var forecast = [Forecast]()
    
    init(){}//defaul const
    
    init(weatherDict:JSON){
        
    }
}
