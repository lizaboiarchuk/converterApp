//
//  ConverterViewController.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }

}
