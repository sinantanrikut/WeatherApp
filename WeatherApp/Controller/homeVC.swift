//
//  homeVC.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 21.03.2022.
//

import UIKit

class homeVC: UIViewController {


    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myView.layer.cornerRadius = 20
        myView.layer.masksToBounds = true
      
    }
    


}
