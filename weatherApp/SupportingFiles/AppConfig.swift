//
//  AppConfig.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation


public struct AppConfig: Codable {
    public static var shared = AppConfig()
    
    
    public let defaultCity: String
    public let defaultCountry: String
    public let defaultUnit: String
    
    public init(
        city:  String  = "Kosice",
        country: String = "",
        unit: String = ""
        ){
        self.defaultCity = city
        self.defaultCountry = country
        self.defaultUnit = unit
    }
    public enum CodingKeys: String, CodingKey {
        case
        defaultCity = "DefaultCity",
        defaultCountry = "DefaultCountry",
        defaultUnit  = "DefaultUnit"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let defaultCity: String = container.contains(.defaultCity) ? try container.decode(String.self, forKey: .defaultCity) : "Kosice"
         let defaultCountry: String = container.contains(.defaultCountry) ? try container.decode(String.self, forKey: .defaultCountry) : ""
         let defaultUnit: String = container.contains(.defaultUnit) ? try container.decode(String.self, forKey: .defaultUnit) : ""
        self.init(city: defaultCity, country: defaultCountry, unit: defaultUnit)
    }
    
}

extension AppConfig {
    
    public init?(fromPlistNamed name: String, in bundle: Bundle = .main) {
        guard let configURL = bundle.url(forResource: name, withExtension: "plist") else {
            assertionFailure("Warning: Missing \(name).plist config file")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: configURL)
            self = try PropertyListDecoder().decode(AppConfig.self, from: data)
            debugPrint("--- Loaded: \(name).plist ------------------")
            debugPrint(self)
            debugPrint("--------------------------------------------")
        } catch {
            assertionFailure("Warning: Failed parsing of \(name).plist config file:\n\(error)")
            return nil
        }
    }
    
}
