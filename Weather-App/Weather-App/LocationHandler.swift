//
//  LocationHandler.swift
//  Weather-App
//
//  Created by Mehmed Muharemovic on 1/22/19.
//  Copyright © 2019 Mehmed Muharemovic. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationStruct : Codable {
    var lat : Double? = nil
    var long : Double? = nil
}

public class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    public var longitude : Double = 0
    public var latitude : Double = 0
    private var locationmanager : CLLocationManager?
    
    public static let sharedInstance : LocationHandler = {
        let instance = LocationHandler()
        return instance
    }()
    
    public override init()
    {
        super.init()
        setup()
    }
    
    func setup()
    {
        if (self.locationmanager == nil) {
            DispatchQueue.main.async {
                self.locationmanager = CLLocationManager()
                
                if CLLocationManager.locationServicesEnabled() {
                    if let mgr = self.locationmanager {
                        mgr.delegate = self
                        mgr.desiredAccuracy = kCLLocationAccuracyKilometer
                        mgr.allowsBackgroundLocationUpdates = false
                        mgr.activityType = .otherNavigation
                    }
                }
            }
        }
    }
    
    func start() {
        if let mgr = self.locationmanager {
            mgr.startMonitoringSignificantLocationChanges()
        }
    }
    
    func stop() {
        if let mgr = locationmanager {
            mgr.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func requestLocation() {
        if let mgr = self.locationmanager {
            mgr.requestLocation()
        }
    }
    
    public func pingLocation() {
        self.locationmanager?.requestLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //location services are ON!
        print("updating location")
        
        if let location = locations.last {
            let locValue:CLLocationCoordinate2D = location.coordinate
            latitude = Double(locValue.latitude)
            longitude = Double(locValue.longitude)
            print("\tlatitude: \(latitude)")
            print("\tlongitude: \(longitude)")
            
        } else {
            // shouldn't happen!
            print("\tcoordinates still empty")
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\tlocation manager failed, error = \(error.localizedDescription)")
        //else, ping location called from app delegate before user is signed in for the first time!
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // If status has not yet been determied, ask for authorization
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // If user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    func getAppLocationForEventSearch() -> LocationStruct {
        //check if users info is available
        var locationStruct = LocationStruct()
        
        if LocationHandler.sharedInstance.latitude != 0.0 && LocationHandler.sharedInstance.longitude != 0.0 {
            print("USE PHONE GPS")
            
            locationStruct.lat = LocationHandler.sharedInstance.latitude
            locationStruct.long = LocationHandler.sharedInstance.longitude
            
            return locationStruct
        }
        
        //bail out
        locationStruct.lat = 0.0
        locationStruct.long = 0.0
        return locationStruct
        
    }
}
