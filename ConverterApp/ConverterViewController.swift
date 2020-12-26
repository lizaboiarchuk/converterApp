//
//  ConverterViewController.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import UIKit

class ConverterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
       // sumFrom.frame.size = CGSize(width: 60, height: 20)
      //  sumTo.frame.size = CGSize(width: 60, height: 20)
       // currencyFrom.frame.size = CGSize(width: 60, height: 20)
      //  currencyTo.frame.size = CGSize(width: 60, height: 20)
        
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == sumTo {
            let value = getValueFromString(input: textField.text!)
            if value == -1 {
                sumFrom.text = ""
            }
            else {
                sumFrom.text = String(format: "%.2f", convert(currencyFrom: currencyTo.text ?? currencies[0], currencyTo: currencyFrom.text ?? currencies[0], sumFrom: value))
            }
        }
        if textField == sumFrom {
            let value = getValueFromString(input: textField.text!)
            if value == -1 {
                sumTo.text = ""
            }
            else {
                sumTo.text = String(format: "%.2f", convert(currencyFrom: currencyFrom.text ?? currencies[0], currencyTo: currencyTo.text ?? currencies[0], sumFrom: value))
            }
        }
    }
    
    @objc func currencyFieldDidChange(_ textField: UITextField) {
        if textField == currencyFrom {
            if textField.text != currencies[fromPicker.selectedRow(inComponent: 0)] {
                textField.text = currencies[fromPicker.selectedRow(inComponent: 0)]
            }
        }
        if textField == currencyTo {
            if textField.text != currencies[toPicker.selectedRow(inComponent: 0)] {
                textField.text = currencies[toPicker.selectedRow(inComponent: 0)]
            }
        }
    }
    
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
        
        if pickerView == fromPicker {
            currencyFrom.text = currencies[row]
           // currencyFrom.endEditing(true)
            sumTo.text = String(format: "%.2f", convert(currencyFrom: currencyFrom.text ?? currencies[0], currencyTo: currencyTo.text ?? currencies[0], sumFrom: getValueFromString(input: sumFrom.text ?? currencies[0])))
        }
        else {
            currencyTo.text = currencies[row]
            //currencyTo.endEditing(true)
            sumFrom.text = String(format: "%.2f", convert(currencyFrom: currencyTo.text ?? currencies[0], currencyTo: currencyFrom.text ?? currencies[0], sumFrom: getValueFromString(input: sumTo.text ?? currencies[0])))
        }
        
    }
    
}
