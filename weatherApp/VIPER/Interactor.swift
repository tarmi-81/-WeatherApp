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
protocol InteractorProtocolOutput {
    func updateWeather(model: WeatherModel)
}

class Interactor {
    var presenter: Presenter?
    var dataModel: WeatherModel?
    
    init() {
        updateCityInfo(city: "")
    }
    func updateCityInfo(city: String){
        var searchCity = city
        if searchCity == "" {
            searchCity = AppConfig.shared.defaultCity + "," + AppConfig.shared.defaultCountry
        }
        NetworkManger.shared.getWeatherDataByCity(city: searchCity, completion: { (result) in
            
            switch result {
            case .success(let weatherModel):
                self.dataModel = weatherModel
                self.presenter!.updateWeather(model: self.dataModel!)
                print(weatherModel)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                self.presenter?.showErrorMessage(title: "Error", message: "\(error.localizedDescription)")
            }
            
        })
    }
    
}
