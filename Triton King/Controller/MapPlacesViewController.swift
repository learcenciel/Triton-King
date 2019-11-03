//
//  MapPlacesViewController.swift
//  Triton King
//
//  Created by Alexander on 01.11.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit
import GoogleMaps

class MapPlacesViewController: UIViewController {
    private let apiClient = APICLient()
    var cityResponse: ResponseObjCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCityList()
    }
    
    private func fetchCityList() {
        apiClient.fetchCityList { [weak self] cityResponse, error in
            if let error = error {
                if error == .parsingError {
                    self?.showMessage("Ошибка парсинга данных")
                }
                return
            }
            self?.cityResponse = cityResponse
            //print(self?.cityResponse?.responseObj.cityArray[0].restaurantLongitute)
            self?.showMarkers(for: (self?.cityResponse?.responseObj.cityArray)!)
        }
    }
    
    private func showMessage(_ message: String) {
        let alertViewController = UIAlertController(title: "Triton", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
    
    func showMarkers(for cityInfo: [CityInfo]) {
        let camera = GMSCameraPosition(latitude: 56.5010397, longitude: 84.9924506, zoom: 4.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        var legitCityList: [CityInfo] = [CityInfo]()
        let curCoord = CLLocation(latitude: 56.4977, longitude: 84.9744)
        
        for elem in cityInfo {
            let cityCoord = CLLocation(latitude: elem.restaurantLatitude, longitude: elem.restaurantLongitute)
            let distanceInMeters = curCoord.distance(from: cityCoord)
            
            if (distanceInMeters / 1000) <= 10 {
                legitCityList.append(elem)
            }
        }
        
        for city in legitCityList {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: city.restaurantLatitude, longitude: city.restaurantLongitute)
            marker.title = city.restaurantName
            marker.snippet = String(city.restaurantId)
            marker.map = mapView
        }
    }
}
