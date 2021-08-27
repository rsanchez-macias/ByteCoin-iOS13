//
//  CoinResponse.swift
//  ByteCoin
//
//  Created by Ricardo Sanchez-Macias on 8/26/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinResponse: Decodable {
    let toCurrency: String?
    let rate: Double?
    
    private enum CodingKeys: String, CodingKey {
        case toCurrency = "asset_id_quote", rate
    }
}
