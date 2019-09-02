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
    var main: MainData
    var weather: [WeatherData]
    func updateWeatherIcon(condition: Int) -> String {

        switch condition {
        case 0...300 :
            return "001lighticons-15"

        case 301...500 :
            return "001lighticons-17"

        case 501...600 :
            return "001lighticons-18"

        case 601...700 :
            return "001lighticons-23"

        case 701...771 :
            return "001lighticons-10"

        case 772...799 :
            return "001lighticons-12"

        case 800 :
            return "001lighticons-2"

        default :
            return "001lighticons-1"
        }
    }
}
//dorobit codable pre ostatne elementy
struct MainData: Codable {
    var temp: Float
    var humidity: Int
   // var presure: Float
   // var temp_max: Float
  //  var temp_min: Float
}
//dorobit codable pre ostatne elementy
struct WeatherData: Codable {
    var id: Int
    var icon: String
   // var main: String
   var description: String
}
