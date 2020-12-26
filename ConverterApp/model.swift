//
//  model.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import Foundation

var currencies: [String] = ["UAH"]
var rates: [String: (rate: Double, full_name: String)] = ["UAH": (1.00,"Українська гривня") ]


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
                                    let full_name: String = dict["txt"] as! String
                                    currencies.append(short_name)
                                    rates[short_name] = (rate, full_name)
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
    return (rates[currencyFrom]!.rate / rates[currencyTo]!.rate * sumFrom)
}






