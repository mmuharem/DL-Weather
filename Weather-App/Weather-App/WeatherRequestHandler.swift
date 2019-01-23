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
    
    public func getWeatherForLocationDay(completion: @escaping (RequestAnswer, [DayWeatherModel]) -> Void ) {
        if let location = LocationHandler.sharedInstance.location {
            
            if let lat = location.lat,
                let long = location.long,
                lat != 0.0,
                long != 0.0 {
                
                let parameters: Parameters = [
                    "lat": "\(lat)",
                    "lon": "\(long)",
                    "APPID" : "\(OPEN_WEATHER_MAP_API_KEY)",
                    "units" : "imperial"
                ]
                
                Alamofire.request(OPEN_WEATHER_MAP_URL + "/weather", method: .get, parameters: parameters)
                    .responseJSON { response in
                        if response.result.isSuccess {
                            guard let data = response.data else {
                                completion(RequestAnswer.Failure, [])
                                return
                            }
                            
                            do {
                                let day = try JSONDecoder().decode(DayWeatherModel.self, from: data)
                                completion(RequestAnswer.Success, [day])
                            } catch let jsonErr {
                                print("Error serializing: \(jsonErr)")
                                completion(RequestAnswer.Failure, [])
                            }
                        } else {
                            completion(RequestAnswer.Failure, [])
                        }
                }
            } else {
                //lat or long nil
                //lat or long 0.0 (default)
                completion(RequestAnswer.Failure, [])
            }
        } else {
            completion(RequestAnswer.Failure, [])
        }
    }
    
    public func getWeatherForLocationWeek(completion: @escaping (RequestAnswer, [DayWeatherModel]) -> Void ) {
        if let location = LocationHandler.sharedInstance.location {
            
            if let lat = location.lat,
                let long = location.long,
                lat != 0.0,
                long != 0.0 {
                
                let parameters: Parameters = [
                    "lat": "\(lat)",
                    "lon": "\(long)",
                    "APPID" : "\(OPEN_WEATHER_MAP_API_KEY)",
                    "units" : "imperial"
                ]
                
                Alamofire.request(OPEN_WEATHER_MAP_URL + "/forecast", method: .get, parameters: parameters)
                    .responseJSON { response in
                        if response.result.isSuccess {
                            
                            guard let data = response.data else {
                                completion(RequestAnswer.Failure, [])
                                return
                            }

                            do {
                                let days = try JSONDecoder().decode(DayWeatherModel.self, from: data)
//                                dump(days)
                                
                                completion(RequestAnswer.Success, [days])
                            } catch let jsonErr {
                                print("Error serializing: \(jsonErr)")
                                completion(RequestAnswer.Failure, [])
                            }
                            
                        } else {
                            completion(RequestAnswer.Failure, [])
                        }
                }
            } else {
                //lat or long nil
                //lat or long 0.0 (default)
                completion(RequestAnswer.Failure, [])
            }
        } else {
            completion(RequestAnswer.Failure, [])
        }
    }
}
