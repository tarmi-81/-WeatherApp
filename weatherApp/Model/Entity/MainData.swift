//
//  MainData.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//


import Foundation

struct MainData: Encodable {
    let temp: Float
    let humidity: Int
    let pressure: Float
    let tempMax: Float
    let tempMin: Float
    
    init(temp: Float,
         humidity: Int,
         pressure: Float,
         tempMax: Float,
         tempMin: Float
         ) {
        self.temp = temp
        self.humidity = humidity
        self.pressure = pressure
        self.tempMax = tempMax
        self.tempMin = tempMin
        
    }
    
}
extension MainData: Decodable {
    internal enum CodingKeys: String, CodingKey { // declaring our keys
        case temp
        case humidity
        case pressure
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
    
    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // extracting the data
        let temp: Float = container.contains(.temp) ? try container.decode(Float.self, forKey: .temp) : -MAXFLOAT
        
        let humidity: Int = container.contains(.humidity) ? try container.decode(Int.self, forKey: .humidity) : -1
        
        let pressure: Float = container.contains(.pressure) ? try container.decode(Float.self, forKey: .pressure) : -MAXFLOAT
        
        let tempMax: Float = container.contains(.tempMax) ? try container.decode(Float.self, forKey: .tempMax) : -MAXFLOAT
        
          let tempMin: Float = container.contains(.tempMax) ? try container.decode(Float.self, forKey: .tempMin) : -MAXFLOAT
        
        self.init(temp: temp,
                  humidity: humidity,
                  pressure: pressure,
                  tempMax: tempMax,
                  tempMin: tempMin
        )
    }
}
