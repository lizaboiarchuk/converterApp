//
//  model.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import Foundation


var currencies: [String] = []
var rates: [String: Double] = [:]

func initData() {
    if let url = URL(string:"https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json") {
            let semaphore = DispatchSemaphore(value: 0)
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        if let array = json as? [Any] {
                            for obj in array {
                                if let dict:NSDictionary = obj as? NSDictionary {
                                    let short_name: String = dict["cc"] as! String
                                    let rate: Double = dict["rate"] as! Double
                                    currencies.append(short_name)
                                    rates[short_name] = rate
                                }
                            }
                           
                        }
                    }
                }
                semaphore.signal()
            }.resume()
            _ = semaphore.wait(wallTimeout: .distantFuture)
        }
}



func convert(currencyFrom: String, currencyTo: String, sumFrom: Double) -> Double {
    return (rates[currencyFrom] ?? 0 / (rates[currencyTo] ?? 1) * sumFrom)
}



