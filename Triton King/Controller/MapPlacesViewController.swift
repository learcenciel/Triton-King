//
//  MapPlacesViewController.swift
//  Triton King
//
//  Created by Alexander on 01.11.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapPlacesViewController: UIViewController {
    private let apiClient = APICLient()
    var cityResponse: ResponseObjCity?
    
    var locationManager: CLLocationManager!
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    var camera: GMSCameraPosition!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        camera = GMSCameraPosition(latitude: 56.5010397, longitude: 84.9924506, zoom: 4.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        view = mapView
        
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
            marker.snippet = city.restaurantEmail
            marker.map = mapView
            marker.icon = UIImage(named: "marker")
        }
    }
}

extension MapPlacesViewController: CLLocationManagerDelegate, GMSMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        mapView.animate(to: camera)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //print(marker.snippet)
        return false
    }
}
