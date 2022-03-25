//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 26.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON


class CurrentWeather{
    
    var _cityName:String!
    var _date:String!
    var _weatherType:String!
    var _currentTemp:Double!
    
    var cityName:String{
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var date:String{
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "\(currentDate)" 
        
        
        return _date
    }
    var weatherType:String{
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp:Double{
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    
    func downloadWeatherDetails(completion:@escaping CompletionHandler){
        
        AF.request(CURRENT_WEATHER_URL,
                   method: .get,
                   encoding: JSONEncoding.default).responseString { (response) in
            
            switch response.result{
                
                case let .success(result):
                
                guard let data = response.data else {return}
                let json = JSON(data)
                
                self._weatherType = json["weather"][0]["main"].stringValue
                self._cityName = json["name"].stringValue.capitalized
                self._currentTemp = json["main"]["temp"].doubleValue
                
                    completion(true)
                case let .failure(error):
                    debugPrint(error)
                    completion(false)
            }
            
        }
                    
        
    }
  
}
