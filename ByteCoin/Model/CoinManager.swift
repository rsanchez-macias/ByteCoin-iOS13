//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DF6D2221-ED9F-4172-A5C9-107844BEF24F"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("error")
                }
                
                if let safeData = data {
                    self.parseJSON(json: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(json: Data) {
        let decoder = JSONDecoder()
        
        do {
            let coinResponse = try decoder.decode(CoinResponse.self, from: json)
            print(coinResponse.rate!)
            print(coinResponse.toCurrency!)
        } catch {
            print(error)
        }
    }
}
