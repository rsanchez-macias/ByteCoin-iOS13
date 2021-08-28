//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func updateUI(_ coinManager: CoinManager, with response: CoinResponse)
    func didReceiveError(_ coinManager: CoinManager, error: Error)
}

struct CoinManager {
    
    // API Constants
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "DF6D2221-ED9F-4172-A5C9-107844BEF24F"
    
    // Picker Options
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didReceiveError(self, error: error!)
                }
                
                if let safeData = data {
                    let response = self.parseJSON(json: safeData)
                    
                    if let safeResponse = response {
                        self.delegate?.updateUI(self, with: safeResponse)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(json: Data) -> CoinResponse? {
        let decoder = JSONDecoder()
        
        do {
            let coinResponse = try decoder.decode(CoinResponse.self, from: json)
            return coinResponse
        } catch {
            return nil
        }
    }

    func getCurrencyTitle(forRowAt row: Int) -> String {
        return currencyArray[row]
    }
    
    func fetchCoinPrice(for currency: String) {
        var urlString = baseURL
        urlString.append("/\(currency)?apikey=\(apiKey)")
        
        performRequest(with: urlString)
    }
}
