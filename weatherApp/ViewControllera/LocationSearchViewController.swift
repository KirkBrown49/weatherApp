//
//  LocationSearchViewController.swift
//  weatherApp
//
//  Created by Kirk Brown on 11/15/18.
//  Copyright © 2018 Kirk Brown. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let apiManager = ApiManager()
    
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func handelError() {
        geocodingData = nil
        weatherData = nil
    }
    
    func retrieveGoecodingData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) {
            (geocodingData, error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handelError()
                return
            }
            if let recievedData = geocodingData {
                self.geocodingData = geocodingData
                self.retrieveWeatherData(latitude: recievedData.latitude,longitude: recievedData.longitude)
            }else{
                self.handelError()
                return
            }
        }
    }
    func retrieveWeatherData(latitude:Double,longitude:Double){
        apiManager.getWeather(at:(latitude,longitude)) {(weatherData,error) in
            if let recievedError = error {
                print(recievedError.localizedDescription)
                self.handelError()
                return
            }
            if let receivedData = weatherData {
                self.weatherData = receivedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handelError()
                return
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            return
        }
        retrieveGoecodingData(searchAddress: searchAddress)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let distinationVc = segue.destination as? WeatherDisplayViewController{
            if let retrievedGeocodingData = geocodingData ,
                let retrievedWeatherData = weatherData {
                distinationVc.displayWeatherData = retrievedWeatherData
                distinationVc.displayGoecodingData = retrievedGeocodingData
            }
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}

