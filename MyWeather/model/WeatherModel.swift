//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Las Rock on 11/11/20.
//

import Foundation
struct WeatherModel{
    
    var conditionId:Int
    
    var temp:Double
    
    var cityName:String
    
    var tempString:String{
        String(format: "%.1f", temp)
    }
    
}
