//
//  FirstViewController.swift
//  WeatherMap
//
//  Created by Senior Node on 19.03.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cityTableView: UITableView!
    var cities: [String] = [String]()
    var cityService = CityService.ShareInstance
    
    override func viewDidLoad() {
        
        self.cities = cityService.getCities()
        cityTableView.dataSource = self
        cityTableView.delegate = self
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:  IndexPath) -> UITableViewCell {
        let cell = self.cityTableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        
        let city = self.cities[indexPath.row]
        cell.cityLabel.text = city
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tabBarController?.selectedIndex = 1
        let cell = self.cityTableView.cellForRow(at: indexPath) as! CityTableViewCell
        let name = cell.cityLabel.text
        (tabBarController?.viewControllers?[1] as! SecondViewController).chooseCity(name: name!)
    }
}

