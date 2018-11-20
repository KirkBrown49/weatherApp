//
//  WeatherDisplayViewController.swift
//  weatherApp
//
//  Created by Kirk Brown on 11/14/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class WeatherDisplayViewController: UIViewController {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cionLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            cionLabel.text = displayWeatherData.condition.icon
            currentTempLabel.text = "\(displayWeatherData.temperature)°"
            highTempLabel.text = "\(displayWeatherData.highTemperature)°"
            lowTempLabel.text = "\(displayWeatherData.lowTemperature)°"
        }
    }
    var displayGoecodingData : GeocodingData! {
        didSet {
            locationLabel.text = displayGoecodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupDefaultUI()
    }
    func setupDefaultUI(){
        locationLabel.text = ""
        cionLabel.text = "😀"
        currentTempLabel.text = "Location?"
        highTempLabel.text = "-"
        lowTempLabel.text = "-"
    }
    @IBAction func unwindToWeatherDisplayWithSegue(segue: UIStoryboardSegue) {}
    
    
}

