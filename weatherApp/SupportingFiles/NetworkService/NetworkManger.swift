//
//  NetworkManger.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import Alamofire

class NetworkManger {
    static let shared = NetworkManger()
    private init(){}
    
    private  let appId = "8420fd1fb7b23a1ee685b7ca3787c7c8"
    private  let apiHost = "api.openweathermap.org"
    private  let apiPath = "/data/2.5/weather"
    private  let scheme = "https"
    private  let headers = ["Content-Type": "application/x-www-form-urlencoded"]

    private let bag = DisposeBag()
    public let weatherModel = PublishSubject<WeatherModel>()
    public let errorSubject = PublishSubject<Error>()

    private var weather: WeatherModel? {
        didSet {
            updateModel()
        }
    }
    private var errorMessage: Error? {
        didSet {
            updateError()
        }
    }

    private enum ParamsName {
        static let city = "q"
        static let lat = "lat"
        static let lon = "lon"
        static let units = "units"
        static let apiID  = "appid"
    }



    lazy private var getBaseComponent: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = apiHost
        urlComponents.path = apiPath
        let queryItemUnits = URLQueryItem(name: ParamsName.units , value: "metric")
        let queryItemToken = URLQueryItem(name: ParamsName.apiID, value: appId)
        urlComponents.queryItems = [ queryItemUnits, queryItemToken]
        return urlComponents
    }()
    
    func getWeatherDataByCity(city: String) {
        getWeather(city: city)
    }
    
    
    private func getWeather(city: String) {
        var urlComponents = self.getBaseComponent
        urlComponents.queryItems?.append(URLQueryItem(name: ParamsName.city, value: city))
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        Alamofire.request(url).rx.responseJSON()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { response in

                        guard let jsonData = response.data else { return }
                        
                                    let decoder = JSONDecoder()
                                    do {
                                        let decodedData = try decoder.decode(WeatherModel.self, from: jsonData)
                                         self.weather = decodedData
                                        print("\(self.weather)")
                                    } catch {
                                        print(error.localizedDescription)
                                        self.errorMessage = error
                                    }
                       

            },
                onError: { error in
                   self.errorMessage = error
                    print(error.localizedDescription)
            })
            .disposed(by: bag)
    }
    
}

extension NetworkManger {

    private func updateError(){
        if let error = errorMessage {
            self.errorSubject.on(.next(error))
        }
    }

    private func updateModel() {
        if let weather = weather {
            self.weatherModel.on(.next(weather))
        }
    }

}
