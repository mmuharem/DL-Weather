//
//  Global.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import Foundation

public struct LocationStruct : Codable {
    var lat : Double? = nil
    var long : Double? = nil
}

public enum RequestAnswer {
    case Success
    case Failure
}

let OPEN_WEATHER_MAP_API_KEY = "34f7e93c0372d3b49b0ba97103e79d66"
let OPEN_WEATHER_MAP_URL = "https://api.openweathermap.org/data/2.5"
