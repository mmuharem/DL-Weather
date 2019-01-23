//
//  WeatherRequestHandler.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import Foundation
import Alamofire

class WeatherRequestHandler {
    
    public static let sharedInstance : WeatherRequestHandler = {
        let instance = WeatherRequestHandler()
        return instance
    }()
    
    public func getWeatherForLocationDay() {
        
    }
    
    public func getWeatherForLocationWeek() {
        
    }
}
