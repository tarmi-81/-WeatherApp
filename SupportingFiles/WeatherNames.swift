//
//  WeatherNames.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation

enum WeatherNames {
 
    case ThunderStorm
    case Drizzle
    case Rain
    case Snow
    case Mist
    case Clouds
    case ClearSky

    var range:Range<Int> {
        switch self {
        case .ThunderStorm :
            return 0..<300
        case .Drizzle :
            return 300..<500
        case .Rain :
            return 500..<600
        case .Snow :
            return 600..<701
        case .Mist :
            return 700..<781
        case .ClearSky:
            return 800..<801
        case .Clouds :
            return 801..<805
        }
    }
}
