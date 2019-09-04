//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 04/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

protocol WeatherViewModelInputs {
    //func nextButtonPressed()
    
}

protocol WeatherViewModelOutputs {
    
    var name: Driver<String>? { get }
    var temp: Driver<String>? { get }
    var image: Driver<UIImage>? { get }
}
protocol WeatherViewModelType {
    var inputs: WeatherViewModelInputs { get }
    var outputs: WeatherViewModelOutputs { get }
}

final class WeatherViewModel: WeatherViewModelInputs, WeatherViewModelOutputs, WeatherViewModelType {
//    func nextButtonPressed() {
//        <#code#>
//    }
    
    
    
    var inputs: WeatherViewModelInputs { return self }
    var outputs: WeatherViewModelOutputs { return self }
    
    var name: Driver<String>?
    var temp: Driver<String>?
    var image: Driver<UIImage>?
    
    var dataModel:WeatherModel?
    var interactor: Interactor
    
    init?(interactor: Interactor){
        self.interactor = interactor
        let model = NetworkManger.shared.weatherModel
        let errorHandling = NetworkManger.shared.errorSubject
       
        
        _ = errorHandling
              .subscribe(onNext: {
                self.interactor.show($0)
              })
        
        
        
        self.name = model
            .map {$0.name}
            .asDriver(onErrorJustReturn: "--")
            .startWith("--")
        
        self.temp =  model
            .map{$0.main}
            .map{return String($0.temp) + AppConfig.shared.defaultUnit }
            .asDriver(onErrorJustReturn: "--")
            .startWith("--" + AppConfig.shared.defaultUnit)
        
        self.image = model
            .map{ $0.updateWeatherIcon(weatherID:$0.weather.first!.id) }
            .map{UIImage(named: String($0))!}
            .asDriver(onErrorJustReturn: UIImage(named: "001lighticons-13")!)
            .startWith(UIImage(named: "001lighticons-13")!)
        
        
    }
}
