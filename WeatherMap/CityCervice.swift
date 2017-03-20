//
//  CityCervice.swift
//  WeatherMap
//
//  Created by Senior Node on 20.03.17.
//  Copyright © 2017 BSUIR. All rights reserved.
//

import Foundation
import SwiftyJSON
import GooglePlaces
import GoogleMaps

class CityService {
    static let ShareInstance = CityService()
    
    private var cities = [String]()
    private var places = [CityInfo]()
    
    var placesClient: GMSPlacesClient
    
    init() {
        GMSPlacesClient.provideAPIKey(ApiConfig.GOOGLE_API_KEY)
        placesClient = GMSPlacesClient.shared()
        
        let pathToJSON = Bundle.main.path(forResource: "City", ofType: "json")
        do {
            let json = try String(contentsOfFile: pathToJSON!, encoding: String.Encoding.utf8)
            parseJsonAndLoadPlaces(jsonString: json)
        } catch {
            return
        }
    }
    
    private func parseJsonAndLoadPlaces(jsonString: String) {
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.city
        
        if let data = jsonString.data(using: String.Encoding.utf8) {
            let json = JSON(data: data)
            let country = json["country"].string
            for item in json["data"].arrayValue {
                self.cities.append(item.string!)
                let city = item.string
                let query = "\(city) \(country)"
                
                self.placesClient.autocompleteQuery(query, bounds: nil, filter: filter, callback: { (results, error) in
                    if(error != nil) {
                        print(error)
                    }
                    if(results == nil || results?.count == 0) {
                        return
                    }
                    
                    let placeId = results?[0].placeID
                    self.placesClient.lookUpPlaceID(placeId!, callback: {(place, placeError) in
                        if(error != nil) {
                            print(placeError)
                        }
                        if(place == nil) {
                            return
                        }
                        
                        var cityInfo = CityInfo(name: city, place: place!, country: country!)
                        
                        self.places.append(cityInfo)
                    })
                    
                });
            }
        }
    }
    
    func getCityByName(name: String) -> CityInfo! {
        for cityInfo in places {
            if cityInfo.name == name {
                return cityInfo
            }
        }
        return nil
    }
    
    func getCities() -> [String] {
        return self.cities
    }
}
