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
    
    //MARK: -- Outlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var degreesImg: UIImageView!
    @IBOutlet weak var humidityImg: UIImageView!
    @IBOutlet weak var windSpeedImg: UIImageView!
    
    //MARK: -- Properties
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var startLat: String?
    var startLot: String?
    
    //MAEK: -- Life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    
    func setUp(){
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            self.startLat = locationManager.location?.coordinate.latitude.description
            self.startLot = locationManager.location?.coordinate.longitude.description
}
        
    }
    
    //MARK: -- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lon = manager.location?.coordinate.longitude.description
        let lat = manager.location?.coordinate.latitude.description
        guard let latitude = lat else {return}
        guard let longitude = lon else {return}
        
        NetWorkManager.sharedInstance.getForecast(lat: latitude, lon: longitude) { (weather, error) in
            self.cityNameLabel.text = weather?.city.name
        }

    }
    
}

    

   


