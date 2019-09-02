//
//  weatherModel.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    var name: String
    var main: MainData
    var weather: [WeatherData]
    
    func updateWeatherIcon(weatherID: Int) -> String {
        
        switch weatherID {
        case WeatherNames.ThunderStorm.range :
            return "001lighticons-15"
            
        case WeatherNames.Drizzle.range :
            return "001lighticons-17"
            
        case WeatherNames.Rain.range :
            return "001lighticons-18"
            
        case WeatherNames.Snow.range :
            return "001lighticons-23"
            
        case WeatherNames.Mist.range:
            return "001lighticons-10"
            
        case WeatherNames.Clouds.range :
            return "001lighticons-8"
            
        case WeatherNames.ClearSky.range :
            return "001lighticons-2"
            
        default :
            return "001lighticons-13"
        }
    }
}





