//
//  ViewController.swift
//  ConverterApp
//
//  Created by lizaboiarchuk on 25.12.2020.
//

import UIKit


class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var convertButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        
        convertButton.layer.cornerRadius = 15
        convertButton.clipsToBounds = true
        convertButton.titleLabel?.font = UIFont.systemFont(ofSize: 19.0)
        
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    
    @IBAction func convert(_ sender: Any) {
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19.0)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 17.0)
        cell.textLabel?.text = (currencies[indexPath.row])
        cell.layoutMargins = UIEdgeInsets.zero
        cell.textLabel?.textAlignment = NSTextAlignment.left
        cell.detailTextLabel?.text = "\(rates[currencies[indexPath.row]]?.rate ?? 0)"
        cell.detailTextLabel?.textAlignment = NSTextAlignment.right
        return cell
    }
}


