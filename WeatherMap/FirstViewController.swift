//
//  FirstViewController.swift
//  WeatherMap
//
//  Created by Senior Node on 19.03.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import UIKit
import GoogleMaps

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 100, height: 100))
        let camera = GMSCameraPosition.camera(withLatitude: -33.86,
                                                          longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.map(withFrame: rect, camera: camera)
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

