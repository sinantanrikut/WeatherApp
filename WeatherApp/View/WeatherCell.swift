//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 26.03.2022.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherTypeLogo: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    
    var Temp:Double!
    var Temp2:Double!
    
    func updateView(forecast:Forecast){
        
        weatherTypeLogo.image = UIImage(named: forecast.weatherType)
        weatherTypeLbl.text = forecast.weatherType
        dateLbl.text = forecast.date
        Temp  = Double(forecast.lowTemp)! -  273.15
        Temp2 = Double(forecast.highTemp)! -  273.15
        minTempLbl.text = "\(String(Int(Temp)))°C"
        maxTempLbl.text = "\(String(Int(Temp2)))°C"
    }
    
}
