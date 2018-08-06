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
    
    func  getForecast(lat: String, lon: String, completion : @escaping (Welcome?, Error?) -> Void) {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&type=like&units=metric&APPID=2cb8d05a806591156f036086ee7e727a"

        
        Alamofire.request(url, method: HTTPMethod.get , parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(_ ):
                do {
                    let forecast = try JSONDecoder().decode(Welcome.self, from: response.data!)
                    completion(forecast, nil)
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
                
            }
        }
    }
    
    // Get imges
    
//    func  getimage(imgCode: String, completion : @escaping (Welcome?, Error?) -> Void) {
//        
//        let url = "http://openweathermap.org/img/w/\(imgCode).png"
//        
//        
//        Alamofire.request(url, method: HTTPMethod.get , parameters: nil).responseJSON { (response) in
//            switch response.result {
//            case .success(_ ):
//                do {
//                    let img = try JSONDecoder().decode(Welcome.self, from: response.data!)
//                    completion(img, nil)
//                }catch let error{
//                    print(error)
//                }
//            case .failure(let error):
//                print(error)
//                completion(nil, error)
//                
//            }
//        }
//    }
    
    
    
    
}











//pars from bundel example
//func loadJson(filename fileName: String) -> [Person]? {
//    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let jsonData = try decoder.decode(ResponseData.self, from: data)
//            return jsonData.person
//        } catch {
//            print("error:\(error)")
//        }
//    }
//    return nil
//}


