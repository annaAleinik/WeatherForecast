//
//  HomeVC.swift
//  WeatherForecast
//
//  Created by  Anita on 8/4/18.
//  Copyright © 2018  Anita. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController,  CLLocationManagerDelegate {
    
    //MARK: -- Properties
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var startLat: String?
    var startLot: String?
    var container: ContainerVC?
    
    //MARK: -- UIProperties
     var cityName: String?
     var toDayDate: String?
    var tempMax: Double?
    var tempMin: Double?
     var humidity: Int?
     var windSpeed: Double?
    
    //MAEK: -- Life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        self.setUp()
    }
    
    
    func setUp(){
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

            self.currentLocation = self.locationManager.location
            self.startLat = currentLocation.coordinate.latitude.description
            self.startLot = currentLocation.coordinate.longitude.description
        }

            guard let latitude = self.startLat else {return}
            guard let longitude = self.startLot else {return}
        

            
            NetWorkManager.sharedInstance.getForecast(lat: latitude, lon: longitude) { (weatherData, error) in
                self.container?.cityNameLabel.text = weatherData?.city.name
                self.toDayDate = weatherData?.list.first?.dtTxt
                self.tempMax = weatherData?.list.first?.main.tempMax
                self.tempMin = weatherData?.list.first?.main.tempMin
                self.humidity = weatherData?.list.first?.main.humidity
                self.windSpeed = weatherData?.list.first?.wind.speed
        
                
            }
            
        }

    
    //MARK: -- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon = manager.location?.coordinate.longitude.description
        let lat = manager.location?.coordinate.latitude.description
        guard let latitude = lat else {return}
        guard let longitude = lon else {return}
        self.startLot = longitude
        self.startLat = latitude
        
        NetWorkManager.sharedInstance.getForecast(lat: latitude, lon: longitude) { (weatherData, error) in
            self.container?.cityNameLabel.text = weatherData?.city.name
            self.toDayDate = weatherData?.list.first?.dtTxt
            self.tempMax = weatherData?.list.first?.main.tempMax
            self.tempMin = weatherData?.list.first?.main.tempMin
            self.humidity = weatherData?.list.first?.main.humidity
            self.windSpeed = weatherData?.list.first?.wind.speed

            }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LoadConteiner") {
            let containerVC: ContainerVC = segue.destination as! ContainerVC
            self.container = containerVC
        }
    }
    

}



