//
//  weatherModel.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation
struct WeatherStruct: Codable {
    var name: String
    var main: TemparatureData
    var weather: [WeatherData]
    
}
//dorobit codable pre ostatne elementy
struct TemparatureData: Codable {
    var temp: Float
    var humidity: Int
   // var presure: Int
   // var temp_max: Float
  //  var temp_min: Float
}
//dorobit codable pre ostatne elementy
struct WeatherData: Codable {
    var id: Int
   // var main: String
   // var description: String
}
