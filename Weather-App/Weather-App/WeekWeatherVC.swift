//
//  SecondViewController.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import UIKit

class WeekWeatherVC: UIViewController {
    
    var currentLocation : LocationStruct?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LocationHandler.sharedInstance.requestLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation(_:)), name: NSNotification.Name(rawValue: "updateLocation"), object: nil)
    }

    @objc func updateLocation(_ notification: Notification) {
//        WeatherRequestHandler.sharedInstance.getWeatherForLocationWeek { (response) in
//            print(response)
//        }
    }

}

