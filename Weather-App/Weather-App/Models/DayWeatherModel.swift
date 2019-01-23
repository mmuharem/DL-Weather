//
//  DayWeatherModel.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import Foundation

struct DayWeatherModel : Decodable {
    var name : String?
    var weather : [WeatherModel]?
    var main : MainModel?
}

struct WeatherModel : Decodable {
    var description : String?
    var icon: String?
    var id : Int?
    var main : String?
}

struct MainModel : Decodable {
    var humidity : Int?
    var pressure : Int?
    var temp : Double?
    var temp_max : Double?
    var temp_min : Double?
}


