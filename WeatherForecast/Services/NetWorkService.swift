//
//  NetWorkService.swift
//  WeatherForecast
//
//  Created by  Anita on 8/4/18.
//  Copyright © 2018  Anita. All rights reserved.
//

import Foundation
import Alamofire

class NetWorkManager {
    
    static let sharedInstance = NetWorkManager()
    
    
    // Get forecast for several days
    
    func  getForecast(lat: String, lon: String, completion : @escaping ([WeatherData]?, Error?) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&type=like&units=metric&APPID=2cb8d05a806591156f036086ee7e727a"

        
        Alamofire.request(url, method: HTTPMethod.get , parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(_ ):
                do {
                    let forecast = try JSONDecoder().decode(WeatherData.self, from: response.data!)
                    completion([forecast], nil)
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
                
            }
        }
    }
    
    
}

