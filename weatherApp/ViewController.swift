//
//  ViewController.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import UIKit
// viper architekturu
// kladanie default mesta do defaults
// ikony
// mapovanie rx na UI 

class ViewController: UIViewController {
    var weatherModel: WeatherStruct?
    //var weatherManager = WeatherDataModel()
 
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func SearchButtonClick(_ sender: Any) {
        updateCityInfo(city: searchText.text ?? "Kosice")
    }
    func setupViews() {
        errorLabel.layer.opacity = 0

        tempLabel.text = "--℃"
        cityLabel.text = "Updating..."
        weatherIcon.image = UIImage(named: "001lighticons-1")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateCityInfo(city: "Kosice")
    }
    func updateCityInfo(city: String){
        NetworkManger.shared.getWeatherDataByCity(city: city, completion: { (result) in
            
            switch result {
            case .success(let weatherModel):
                self.weatherModel = weatherModel
                    self.updateWeatherInfo(info: weatherModel)
                print(weatherModel)
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
            
        })
    }
    
    func updateWeatherInfo(info: WeatherStruct) {
        tempLabel.text = Int(info.main.temp).description + "℃"
        cityLabel.text = info.name
        guard let currentWeather = info.weather.first else {
            weatherIcon.image = UIImage(named: "001lighticons-1")
            return
        }
        weatherIcon.image  = UIImage(named: info.updateWeatherIcon(weatherID: currentWeather.id))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

}
