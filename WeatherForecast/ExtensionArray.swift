//
//  ExtensionArray.swift
//  WeatherForecast
//
//  Created by  Anita on 8/7/18.
//  Copyright © 2018  Anita. All rights reserved.
//

import Foundation
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
