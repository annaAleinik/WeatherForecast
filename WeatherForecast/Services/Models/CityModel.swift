//
//  CityModel.swift
//  WeatherForecast
//
//  Created by  Anita on 8/4/18.
//  Copyright © 2018  Anita. All rights reserved.
//

import Foundation

struct ResponseData: Codable {
     var city: [CitysList]
}

struct CitysList : Codable {
    var id: Int
     var name: String
     var country: String
     var coord: [Coordinates]
    
}

struct Coordinates: Codable {
    var lon: Double
    var lat: Double
}


