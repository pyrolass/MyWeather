//
//  ViewController.swift
//  MyWeather
//
//  Created by Las Rock on 11/11/20.
//

import UIKit


class ViewController: UIViewController,WeatherDelegate, UITextFieldDelegate {
   
    

    @IBOutlet weak var searchLabel: UITextField!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
   
    
    var weatherBrain=WeatherBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherBrain.delegate=self
        
        searchLabel.delegate=self
        // Do any additional setup after loading the view.
    }


    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchLabel.endEditing(true)
        searchLabel.text=""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchLabel.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchLabel.text == "" {
            searchLabel.placeholder="type somenthing"
            
            return false
        }
        else{
            
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName=searchLabel.text{
            searchLabel.text=cityName
            
            weatherBrain.fetchWeather(cityName: cityName)
        }
        
        searchLabel.text=""
    }
    func weatherUpdated(weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.tempLabel.text=weatherModel.tempString
        
            self.cityLabel.text=weatherModel.cityName
        
    }
    }
    
    func failedWithError(error: Error) {
        print(error)
    }
    
}

