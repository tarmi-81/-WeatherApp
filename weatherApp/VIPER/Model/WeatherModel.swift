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
    var temp: Driver<String>? { get }
     var image: Driver<UIImage>? { get }
}
protocol WeatherViewModelType {
    var inputs: WeatherViewModelInputs { get }
    var outputs: WeatherViewModelOutputs { get }
    func updateWeather(interactor: Interactor)
}

final class WeatherViewModel: WeatherViewModelInputs, WeatherViewModelOutputs, WeatherViewModelType {
  
    
    var inputs: WeatherViewModelInputs { return self }
    var outputs: WeatherViewModelOutputs { return self }
    
    private let nextButtonPressedSubject = PublishSubject<Void>()
    func nextButtonPressed() {
        nextButtonPressedSubject.onNext(())
    }
    var name: Driver<String>?
    var temp: Driver<String>?
    var image: Driver<UIImage>?

    var dataModel:WeatherModel?
    
    init?(interactor: Interactor){
        self.updateWeather(interactor: interactor)
    

        
    }
  public   func updateWeather(interactor: Interactor){
        guard interactor.dataModel != nil else {return}
        self.dataModel = interactor.dataModel
        let nameValue = BehaviorRelay<String>(value: self.dataModel!.name)
        let mainData = BehaviorRelay<MainData>(value: self.dataModel!.main)
        let weatherData = BehaviorRelay<[WeatherData]>(value: self.dataModel!.weather)
        self.name =  nameValue
            .asDriver()
            .startWith("")

        self.temp =  mainData
            .map{return String($0.temp) + AppConfig.shared.defaultUnit }
            .asDriver(onErrorJustReturn: "--")
            .startWith("--" + AppConfig.shared.defaultUnit)

        self.image = weatherData
            .map{
                $0.first!.id }
            .map{  self.dataModel!.updateWeatherIcon(weatherID:$0)}
            .map{
                UIImage(named: String($0))!}

            .asDriver(onErrorJustReturn: UIImage(named: "001lighticons-13")!)
            .startWith(UIImage(named: "001lighticons-13")!)


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





