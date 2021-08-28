//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {

    // Outlets
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Properties to support functionality
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerSourceAndDelegate()
        setupCoinManager()
    }
    
    func setPickerSourceAndDelegate() {
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func setupCoinManager() {
        coinManager.delegate = self
    }
}

// MARK: - UIPickerViewDataSource
extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

// MARK: - UIPickerViewDelegate
extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.getCurrencyTitle(forRowAt: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.getCurrencyTitle(forRowAt: row)
        coinManager.fetchCoinPrice(for: selectedCurrency)
    }
}

// MARK: - CoinDelegate
extension CoinViewController: CoinManagerDelegate {
    func didReceiveError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }
    
    func updateUI(_ coinManager: CoinManager, with response: CoinResponse) {
        DispatchQueue.main.async {
            self.currencyLabel.text = response.toCurrency
            self.bitcoinLabel.text = String(format: "%.2f", response.rate ?? 0.0)
        }
    }
}

