//
//  ConverterViewController.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var sumTo: UITextField!
    @IBOutlet weak var sumFrom: UITextField!
    @IBOutlet weak var currencyTo: UITextField!
    @IBOutlet weak var currencyFrom: UITextField!
    let fromPicker = UIPickerView()
    let toPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromPicker.dataSource = self
        fromPicker.delegate = self
        toPicker.dataSource = self
        toPicker.delegate = self
        
        currencyFrom.inputView = fromPicker
        currencyTo.inputView = toPicker
        currencyFrom.text = currencies[0]
        currencyTo.text = currencies[1]
        sumFrom.text = "0.00"
        sumTo.text = "0.00"
 
        sumTo.addTarget(self, action: #selector(ConverterViewController.textFieldDidChange(_:)), for: .editingChanged)
        sumFrom.addTarget(self, action: #selector(ConverterViewController.textFieldDidChange(_:)), for: .editingChanged)
        currencyFrom.addTarget(self, action: #selector(ConverterViewController.currencyFieldDidChange(_:)), for: .editingChanged)
        currencyTo.addTarget(self, action: #selector(ConverterViewController.currencyFieldDidChange(_:)), for: .editingChanged)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ConverterViewController.dismissAllEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissAllEditing() {
        view.endEditing(true)
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }

}


//handling pickerViews
extension ConverterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(currencies[row]) - \(rates[currencies[row]]?.full_name ?? "")"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
    inComponent component: Int) {
        var currency_from = currencyFrom
        var currency_to = currencyTo
        var sum_from = sumFrom
        var sum_to = sumTo
        if pickerView == toPicker {
            currency_from = currencyTo
            currency_to = currencyFrom
            sum_from = sumTo
            sum_to = sumFrom
        }
        currency_from!.text = currencies[row]
        sum_to!.text = String(format: "%.2f", convert(currencyFrom: currency_from!.text ?? currencies[0], currencyTo: currency_to!.text ?? currencies[0], sumFrom: getValueFromString(sum_from!.text ?? currencies[0])))
    }
}


//hadling textFieldsChanges
extension ConverterViewController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        var currency_from = currencyFrom
        var currency_to = currencyTo
        var sum_to = sumTo
        if textField == sumTo {
            currency_from = currencyTo
            currency_to = currencyFrom
            sum_to = sumFrom
        }
        let value = getValueFromString(textField.text!)
        if value == -1 {
            sum_to!.text = ""
        }
        else {
            sum_to!.text = String(format: "%.2f", convert(currencyFrom: currency_from!.text ?? currencies[0], currencyTo: currency_to!.text ?? currencies[0], sumFrom: value))
        }
    }
    
    @objc func currencyFieldDidChange(_ textField: UITextField) {
        var picker = fromPicker
        if textField == currencyTo {
            picker = toPicker
        }
        if textField.text != currencies[picker.selectedRow(inComponent: 0)] {
            textField.text = currencies[picker.selectedRow(inComponent: 0)]
        }
    }
    
    @IBAction func swapCurrencies(_ sender: Any) {
        let cur = currencyFrom.text
        currencyFrom.text = currencyTo.text
        currencyTo.text = cur
        let sum = validateAndRound(sumFrom.text ?? "")
        sumFrom.text = validateAndRound(sumTo.text ?? "")
        sumTo.text = sum
    }
}
