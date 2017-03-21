//
//  SecondViewController.swift
//  WeatherMap
//
//  Created by Senior Node on 19.03.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import GoogleMaps

class SecondViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var cityService = CityService.ShareInstance
    var weatherService = WeatherService()
    var lastMarker:GMSMarker! = nil
    
    override func viewDidLoad() {
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.delegate = self
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        if (lastMarker != nil) {
            lastMarker.map = nil
        }
        let cityInfo = cityService.getNearestCity(coordinate: coordinate)
        if(cityInfo == nil) {
            showMessage(message: "Not all cities are loaded. Wait few seconds, please.")
            return
        }
        lastMarker = GMSMarker(position: (cityInfo!.place.coordinate))
        lastMarker.title = cityInfo?.name
        weatherService.getWeather(city: (cityInfo?.name)!, marker: lastMarker)
        lastMarker.snippet = "\(cityInfo?.place.coordinate.latitude), \(cityInfo?.place.coordinate.longitude)"
        lastMarker.map = mapView
        mapView.selectedMarker = lastMarker
        let camera = GMSCameraPosition.camera(withLatitude: (cityInfo?.place.coordinate.latitude)!,
                                              longitude: (cityInfo?.place.coordinate.longitude)!, zoom: 4)
        mapView.camera = camera
    }
    
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func chooseCity(name: String) {
        if (lastMarker != nil) {
            lastMarker.map = nil
        }
        let cityInfo = cityService.getCityByName(name: name)
        if(cityInfo == nil) {
            showMessage(message: "No such city.")
            return
        }
        lastMarker = GMSMarker(position: (cityInfo!.place.coordinate))
        lastMarker.title = cityInfo?.name
        weatherService.getWeather(city: (cityInfo?.name)!, marker: lastMarker)
        lastMarker.map = mapView
        mapView.selectedMarker = lastMarker
        let camera = GMSCameraPosition.camera(withLatitude: (cityInfo?.place.coordinate.latitude)!,
                                              longitude: (cityInfo?.place.coordinate.longitude)!, zoom: 4)
        mapView.camera = camera
    }
}

