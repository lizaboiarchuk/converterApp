//
//  util.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 26.12.2020.
// some utilitues functions

import Foundation

func getValueFromString (input: String) -> Double {
    var value = Double(-1)
    if let v = Double(input) {
        if v >= 0 {
            value = v
        }
    }
    return value
}
