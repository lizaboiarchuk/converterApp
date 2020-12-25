//
//  ViewController.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var convertButton: UIButton!
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }

    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(currencies[indexPath.row]) - \(rates[currencies[indexPath.row]] ?? 0)"
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }

    
    @IBAction func convert(_ sender: Any) {
        print("convert")
    }
    
    override func viewDidLoad() {
        initData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


