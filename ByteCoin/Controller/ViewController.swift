//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coinManager.performRequest(with: "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=DF6D2221-ED9F-4172-A5C9-107844BEF24F")
    }


}

