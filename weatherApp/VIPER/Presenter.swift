//
//  Presenter.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation
import UIKit

class Presenter: InteractorProtocolOutput {
    let defaultImage = "001lighticons-13"
    var view: WeatherViewController?
    var interactor:Interactor?
    var router: Router?
    init() {

    }
    func setupView() {
        guard let view = self.view else { return }
        view.errorLabel!.layer.opacity = 0
        
        view.tempLabel.text = "--"
        view.cityLabel.text = "Updating..."
        view.weatherIcon.image = UIImage(named: defaultImage)
    }
    
    func updateWeather(model: WeatherModel) {
        guard let view = self.view else { return }
        view.tempLabel.text = Int(model.main.temp).description + AppConfig.shared.defaultUnit
        view.cityLabel.text = model.name
        guard let currentWeather = model.weather.first else {
            view.weatherIcon.image = UIImage(named: defaultImage)
            return
        }
        view.weatherIcon.image  = UIImage(named: model.updateWeatherIcon(weatherID: currentWeather.id))
    }
    func startLoading(){
        setupView()
    }
    func searchWeather(city: String){
        startLoading()
        interactor!.updateCityInfo(city: city)
    }
    func showErrorMessage(title: String, message: String){
        router?.showErrorMessage(title: title, message: message)
    }
}
