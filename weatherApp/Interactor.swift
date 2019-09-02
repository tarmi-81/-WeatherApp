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
        updateCityInfo(city: "Kosice,SK")
    }
    func updateCityInfo(city: String){
        NetworkManger.shared.getWeatherDataByCity(city: city, completion: { (result) in
            
            switch result {
            case .success(let weatherModel):
                self.dataModel = weatherModel
                self.presenter!.updateWeather(model: self.dataModel!)
                print(weatherModel)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
            
        })
}
}
