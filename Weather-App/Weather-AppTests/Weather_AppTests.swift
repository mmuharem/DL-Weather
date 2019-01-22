//
//  Weather_AppTests.swift
//  Weather-AppTests
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import XCTest
@testable import Weather_App

class Weather_AppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFirstViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let individual = storyboard.instantiateInitialViewController() as! IndividualWeatherVC
        let _ = individual.view
    }
    
    func testConnectionToOpenWeather() {
        
    }

}
