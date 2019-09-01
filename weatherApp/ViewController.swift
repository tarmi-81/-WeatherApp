//
//  ViewController.swift
//  weatherApp
//
//  Created by Jozef Gmuca on 01/09/2019.
//  Copyright © 2019 Jozef Gmuca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // NetworkManger().getWeatherDataByCity(city:"Kosice",completion: )
        NetworkManger().getWeatherDataByCity(city: "Kosice", completion: { (result) in
            print(result)
        })
    }


}

