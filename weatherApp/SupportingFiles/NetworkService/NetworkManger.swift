//
//  NetworkManger.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManger {
    static let shared = NetworkManger()
    private init(){}
    
    private  let appId = "8420fd1fb7b23a1ee685b7ca3787c7c8"
    private  let apiHost = "api.openweathermap.org"
    private  let apiPath = "/data/2.5/weather"
    private  let scheme = "https"
    private  let headers = ["Content-Type": "application/x-www-form-urlencoded"]
    
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
    func getWeatherDataByCity(city: String, completion: ((Result<WeatherModel>) -> Void)?) {
        var urlComponents = self.getBaseComponent
        urlComponents.queryItems?.append(URLQueryItem(name: ParamsName.city, value: city))
        getWeather(urlComponents: urlComponents, completion: completion)
    }
    private func getWeather<T: Decodable>(urlComponents: URLComponents , completion: ((Result<T>) -> Void)?) {
       
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        AF.request(request).responseJSON { response in
            guard response.error == nil else { print("ERROR: - \(String(describing: response.error))"); return}
            print(response)
            guard let jsonData = response.data else { return }
            print(jsonData)
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: jsonData)
                completion?(.success(decodedData))
            } catch {
                completion?(.failure(error))
                print(error.localizedDescription)
            }
        }
        
    }
    
    enum Result<Value> {
        case success(Value)
        case failure(Error)
    }
}
