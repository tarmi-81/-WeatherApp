//
//  Presenter.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class Presenter //InteractorProtocolOutput
{
    let defaultImage = "001lighticons-13"
    var view: WeatherViewController?
    var interactor:Interactor?
    var router: Router?
    private let bag = DisposeBag()
    var viewModel: WeatherViewModelType?
    init() {
       
    }
    
    func setupView() {
         viewModel = WeatherViewModel(interactor: interactor!)
        guard let view = self.view else { return }

        viewModel?.outputs.name?
            .drive(view.cityLabel.rx.text)
            .disposed(by: bag)

        viewModel?.outputs.temp?
            .drive(view.tempLabel.rx.text)
            .disposed(by: bag)
        viewModel?.outputs.image?
            .drive(view.weatherIcon.rx.image)
            .disposed(by: bag)
    }
    
    
    func startLoading(){
    // sow spiner 
    }
    
    func searchWeather(city: String){

        interactor!.updateCityInfo(city: city)
         startLoading()
    }
    
    func showErrorMessage(title: String, message: String){
        router?.showErrorMessage(title: title, message: message)
    }
}
