//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 14.03.2022.
//

import UIKit

class firstPageVC: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var getStartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(CURRENT_WEATHER_URL)
        print(FORECAST_WEATHER_URL)
        weatherUpdateLabel()
        getStartButton.layer.cornerRadius = 12
    }

    func weatherUpdateLabel(){
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 33), NSAttributedString.Key.foregroundColor : UIColor.white]

        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 33), NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9720632434, green: 0.9601919055, blue: 0, alpha: 1)]

            let attributedString1 = NSMutableAttributedString(string:"Weather News", attributes:attrs1)

            let attributedString2 = NSMutableAttributedString(string:" & Feed", attributes:attrs2)

            attributedString1.append(attributedString2)
            self.weatherLabel.attributedText = attributedString1
        
    }
    
    
    @IBAction func btnClicked(_ sender: Any) {
        performSegue(withIdentifier: FIRS_TO_MAIN, sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == FIRS_TO_MAIN {
            guard segue.destination is homeVC else {return}
        

        }
    }

}

