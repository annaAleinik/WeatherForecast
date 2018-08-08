//
//  ContainerVC.swift
//  WeatherForecast
//
//  Created by  Anita on 8/4/18.
//  Copyright © 2018  Anita. All rights reserved.
//

import Foundation
import UIKit

class ContainerVC: UIViewController {
    
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

    var selectedDay: WeatherData? = nil {
        didSet{
            self.cityNameLabel.text = ""
        }
    }

    
    //MAEK: -- Life cyrcle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

