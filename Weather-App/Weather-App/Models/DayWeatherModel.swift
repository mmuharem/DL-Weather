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
    var city : CityModel?
    var list : [ListModel]?
}

struct WeatherModel : Decodable {
    var description : String?
    var icon: String?
    var id : Int?
    var main : String?
}

struct MainModel : Decodable {
    var humidity : Int?
    var pressure : Double?
    var temp : Double?
    var temp_max : Double?
    var temp_min : Double?
}

struct CityModel : Decodable {
    var country : String?
    var name : String?
    var population : Int?
}

struct ListModel : Decodable {
    var main : MainModel?
    var dt : Float?
    let dt_txt: String
    var weather : [WeatherModel]?
}




