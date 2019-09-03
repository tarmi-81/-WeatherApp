//
//  weatherModel.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

protocol WeatherViewModelInputs {
    func nextButtonPressed()
   
}

protocol WeatherViewModelOutputs {
   
    var name: Driver<String>? { get }
}
protocol WeatherViewModelType {
    var inputs: WeatherViewModelInputs { get }
    var outputs: WeatherViewModelOutputs { get }
}

final class WeatherViewModel: WeatherViewModelInputs, WeatherViewModelOutputs, WeatherViewModelType {
  
    
    var inputs: WeatherViewModelInputs { return self }
    var outputs: WeatherViewModelOutputs { return self }
    
    private let nextButtonPressedSubject = PublishSubject<Void>()
    func nextButtonPressed() {
        nextButtonPressedSubject.onNext(())
    }
    let name: Driver<String>?
    public let model : PublishSubject<WeatherModel> = PublishSubject()
    
    init?(interactor: Interactor){
        guard interactor.dataModel != nil else {return nil}
        self.model.onNext(interactor.dataModel)
        let tmp = BehaviorRelay<String>(value: interactor.dataModel!.name)
        self.name =  tmp
                    .asDriver()
                    .startWith("")
        
        
        
        
        
    }
   
   
}


struct WeatherModel: Codable {
    var name: String 
    var main: MainData
    var weather: [WeatherData]
    
    func updateWeatherIcon(weatherID: Int) -> String {
        
        switch weatherID {
        case WeatherNames.ThunderStorm.range :
            return "001lighticons-15"
            
        case WeatherNames.Drizzle.range :
            return "001lighticons-17"
            
        case WeatherNames.Rain.range :
            return "001lighticons-18"
            
        case WeatherNames.Snow.range :
            return "001lighticons-23"
            
        case WeatherNames.Mist.range:
            return "001lighticons-10"
            
        case WeatherNames.Clouds.range :
            return "001lighticons-8"
            
        case WeatherNames.ClearSky.range :
            return "001lighticons-2"
            
        default :
            return "001lighticons-13"
        }
    }
}





