//
//  Router.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 02/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import Foundation
import UIKit

class Router {
    var vc: WeatherViewController = WeatherViewController()
    let presenter = Presenter()
    let interactor = Interactor()
    var navigationController: UINavigationController?
    
    init() {
        
        vc = initView()
        presenter.interactor = interactor
        presenter.router = self
        interactor.presenter = presenter
        
        navigationController = UINavigationController(rootViewController: vc)
        navigationController?.isNavigationBarHidden = true
    }
    
    func initView() -> WeatherViewController {
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc:WeatherViewController = storyBoard.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        
        vc.presenter = self.presenter
        self.presenter.view = vc
        
        return vc
    }
    func showErrorMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //only close alert
        }))
        navigationController!.present(alert, animated: true, completion: nil)
    }
}
