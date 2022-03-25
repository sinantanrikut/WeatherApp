//
//  homeVC.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 21.03.2022.
//

import UIKit

class homeVC: UIViewController {
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentWeathericon: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    
    var currentWeather:CurrentWeather!
    var Temp:Double!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myView.layer.cornerRadius = 20
        myView.layer.masksToBounds = true
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails { Success in
            print(Success)
            self.updateView()
        }
    }
    
    func updateView(){
        locationLabel.text = currentWeather.cityName
        Temp  = self.currentWeather.currentTemp - 273.15
        currentTempLbl.text = "\(String(Int(Temp)))"
        currentWeathericon.image = UIImage(named: currentWeather.weatherType)
        dateLabel2.text = currentWeather.date
    }
    


}
