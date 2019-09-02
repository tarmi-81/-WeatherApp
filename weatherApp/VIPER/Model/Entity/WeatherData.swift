//
//  WeatherData.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation

struct WeatherData: Encodable {
    var id: Int
    var icon: String
    var main: String
    var description: String
    
    init(id: Int,
        icon: String,
         main: String,
         description: String
        ) {
        self.id = id
        self.icon = icon
        self.main = main
        self.description = description
    }
}
extension WeatherData: Decodable {
    internal enum CodingKeys: String, CodingKey {
        case id
        case icon
        case main
        case description
    }
    
    internal init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // extracting the data
        let id: Int = container.contains(.id) ? try container.decode(Int.self, forKey: .id) : -1
        let icon: String = container.contains(.icon) ? try container.decode(String.self, forKey: .icon) : ""
        let main: String = container.contains(.main) ? try container.decode(String.self, forKey: .main) : ""
        let description: String = container.contains(.description) ? try container.decode(String.self, forKey: .description) : ""
        
        self.init(id: id,
                  icon: icon,
                  main: main,
                  description: description
        )
    }
}
