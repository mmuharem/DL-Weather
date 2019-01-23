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

//https://www.uraimo.com/swiftbites/rounding-doubles-to-specific-decimal-places/
extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {

    func DateToString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        //        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
}
