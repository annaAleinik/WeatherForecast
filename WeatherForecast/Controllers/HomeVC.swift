//
//  HomeVC.swift
//  WeatherForecast
//
//  Created by  Anita on 8/4/18.
//  Copyright © 2018  Anita. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController,  CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -- Properties
    var locationManager:CLLocationManager!
    var startLat: String?
    var startLot: String?
    var container: ContainerVC?
    
    var arrForecast = [Welcome]()
    
    //MAEK: -- Life cyrcle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.setUp()
    }
    
    
    func setUp(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        }

    
    //MARK: -- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lon = locations.last?.coordinate.longitude else {return}
        guard let lat = locations.last?.coordinate.latitude else {return}
        let longitude = String(lon)
        let latitude = String(lat)
        
        NetWorkManager.sharedInstance.getForecast(lat: latitude, lon: longitude) { (weatherData, error) in
            
            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            if let array = weatherData {
                self.arrForecast = array
                self.tableView.reloadData()
            }
            self.container?.cityNameLabel.text = weatherData?.first?.city.name
            self.container?.dateLable.text = weatherData?.first?.list.first?.dtTxt

            
            guard let humidity = weatherData?.first?.list.first?.main.humidity else {return}
            guard let windSpeed = weatherData?.first?.list.first?.wind.speed else {return}
            self.container?.humidityLabel.text = String(describing: humidity)
            self.container?.windSpeedLabel.text = String(describing: windSpeed)
            
            let mainIcon = weatherData?.first?.list.first?.weather.first?.icon
            let mainImgLink = APIConst.baseURLImg + mainIcon! + APIConst.formatImg
            self.container?.mainImage.downloadedFrom(link: mainImgLink)
           
    }
        tableView.delegate = self
        tableView.dataSource = self

}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LoadConteiner") {
            let containerVC: ContainerVC = segue.destination as! ContainerVC
            self.container = containerVC
        }
    }
    
    
    //MARK: --UITableViewDataSource


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrForecast.first?.list.count)!
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let tempMax = self.arrForecast[indexPath.row].list[indexPath.row].main.tempMax
        let tempMin = self.arrForecast[indexPath.row].list[indexPath.row].main.tempMin
        let max = String(format:"%.1f", tempMax)
        let min = String(format:"%.1f", tempMin)
        
        cell.tempLabel.text = "\(max)/\(min)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



