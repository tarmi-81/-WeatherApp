//
//  ViewController.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
    var presenter:Presenter?
   
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchText: UITextField!
    private let bag = DisposeBag()
    var viewModel: WeatherViewModelType?
    @IBAction func SearchButtonClick(_ sender: Any) {
        presenter?.searchWeather(city: searchText.text ?? "" )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherViewModel(interactor: self.presenter!.interactor!)
        viewModel?.outputs.name?
            .drive(cityLabel.rx.text)
            .disposed(by: bag)
        
        viewModel?.outputs.temp?
            .drive(tempLabel.rx.text)
            .disposed(by: bag)
        viewModel?.outputs.image?
            .drive(weatherIcon.rx.image)
            .disposed(by: bag)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

}
