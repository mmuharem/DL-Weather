//
//  FirstViewController.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import UIKit
import Alamofire

class IndividualWeatherVC: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var hourlyTableView: UITableView!
    @IBOutlet weak var FiveDayForecastButton: UIBarButtonItem!
    
    var currentLocation : LocationStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LocationHandler.sharedInstance.start()
        
        //Get current location
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation(_:)), name: NSNotification.Name(rawValue: "updateLocation"), object: nil)
    }
    
    @objc func updateLocation(_ notification: Notification) {
        WeatherRequestHandler.sharedInstance.getWeatherForLocationDay { (response, result) in
            if response == RequestAnswer.Success {
                self.cityLabel.text = result.first?.name
                if let temp = result.first?.main?.temp {
                    self.temperatureLabel.text = "\(temp) F"
                }
                
            } else if response == RequestAnswer.Failure {
                print("Error")
            }
        }
    }
    
    @IBAction func FiveDayForecastButtonClick(_ sender: Any) {
        if let tabBar = self.tabBarController {
            tabBar.selectedIndex = 1
        }
    }
    


}

