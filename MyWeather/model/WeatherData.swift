//
//  WeatherData.swift
//  MyWeather
//
//  Created by Las Rock on 11/11/20.
//

import Foundation

struct WeatherData:Codable{
    var weather:[Weather]
    
    var main:Main
    
    var name:String
    
}

struct Weather:Codable{
    var id:Int
}

struct Main:Codable{
    var temp:Double
}
