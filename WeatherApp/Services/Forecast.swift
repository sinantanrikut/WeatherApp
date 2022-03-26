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
    
  //setter
    
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
    var highTemp:String{
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    var lowTemp:String{
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    init(){}//defaul const
    
    init(weatherDict:JSON){
        _lowTemp = weatherDict["main"]["temp_min"].stringValue
        _highTemp = weatherDict["main"]["temp_max"].stringValue
        _weatherType = weatherDict["weather"][0]["main"].stringValue
        
        
        //Convert işlemleri
        let date = weatherDict["dt"].doubleValue
        let unixConvertedDate = Date(timeIntervalSince1970: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeStyle = .none
        _date = unixConvertedDate.dayOfWeek()
        
    }
    
    func downloadForecastData(completion:@escaping CompletionHandler){
        AF.request(FORECAST_WEATHER_URL,
                   method: .get,
                   encoding: JSONEncoding.default).responseString { (response) in
            
            switch response.result{
                
                case let .success(result):
                
                guard let data = response.data else {return}
                let json = JSON(data)
                
                if let list = json["list"].array{
                    for obj in list{
                        let forecast = Forecast(weatherDict: obj)
                        Forecast.forecast.append(forecast)
                    }
                }
               
                    completion(true)
                case let .failure(error):
                    debugPrint(error)
                    completion(false)
            }
        }
    }
}

extension Date{
    func dayOfWeek() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
