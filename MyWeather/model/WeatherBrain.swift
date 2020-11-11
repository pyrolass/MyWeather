//
//  WeatherBrain.swift
//  MyWeather
//
//  Created by Las Rock on 11/11/20.
//

import Foundation


protocol WeatherDelegate{
    
    func weatherUpdated(weatherModel:WeatherModel)
    func failedWithError(error:Error)
}

struct WeatherBrain{
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=dd64df3efd0843a6dee7b03a9d8a6dc4&units=metric"
    
    var delegate:WeatherDelegate?
    
    func fetchWeather(cityName:String){
        let urlString="\(url)&q=\(cityName)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String){
        
        if let url=URL(string: urlString){
            
            let session=URLSession(configuration: .default)
            
            let task=session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.failedWithError(error: error!)
                    
                    return
                }
                
                if let safeData=data{
                    if let weather = parseJSON(with: safeData){
                        self.delegate?.weatherUpdated(weatherModel: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(with weatherData:Data)->WeatherModel?{
        let decoder=JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp=decodedData.main.temp
            let cityName=decodedData.name
            
            let weather=WeatherModel(conditionId: id, temp: temp, cityName: cityName)
            return weather
            
        }
        
        catch{
            delegate?.failedWithError(error: error)
            return nil
        }
    }
}
