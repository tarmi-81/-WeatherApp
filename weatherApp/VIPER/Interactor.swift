//
//  Interactor.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation

protocol InteractorProtocolInput {
    func searchCity(name:String)
}
//protocol InteractorProtocolOutput {
////    func updateWeather()
//}

class Interactor {
    var presenter: Presenter?
    var dataModel: WeatherModel?
    
    init() {
        updateCityInfo(city: "")
    }
    func show(_ error: Error) {
         self.presenter?.showErrorMessage(title: "Error", message: "\(error.localizedDescription)")
    }
    
    func updateCityInfo(city: String){
        var searchCity = city
        if searchCity == "" {
            searchCity = AppConfig.shared.defaultCity + "," + AppConfig.shared.defaultCountry
        }
        NetworkManger.shared.getWeatherDataByCity(city: searchCity)
    }
}
