//
//  UserLocationService.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


protocol UserLocationServiceType: Service {
    
    //callback
    var callBackUserLocationWasChanged: SimpleClosure<CLLocationCoordinate2D>? { get set }
    
    //getters
    var userLocation: CLLocationCoordinate2D? { get }
    var userAddress: String? { get }
    
}

class UserLocationService: NSObject, UserLocationServiceType {

    private var locationManager: CLLocationManager?
    private var lastUserLocation: CLLocationCoordinate2D?
    private var lastUserAddress: String?

    var callBackUserLocationWasChanged: SimpleClosure<CLLocationCoordinate2D>?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.showsBackgroundLocationIndicator = true
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.locationManager?.requestWhenInUseAuthorization()
            }
        } else if status != .denied && status != .restricted {
            locationManager?.startUpdatingLocation()
        }
    }
    
    deinit {
        print("UserLocationService deinit")
    }
}

//MARK:- Getters
extension UserLocationService {
    
    var userLocation: CLLocationCoordinate2D? {
        return lastUserLocation
    }
    
    var userAddress: String? {
        return lastUserAddress ?? "n/a"
    }
}

//MARK:- CLLocationManagerDelegate
extension UserLocationService: CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("locationManager didUpdateLocations to \(String(describing: locations.last))")
        lastUserLocation = locations.last?.coordinate
//        updateUserAddress(locations.last)

        guard let location = locations.last?.coordinate else { return }
        callBackUserLocationWasChanged?(location)
        
        guard let locationToDatabase = locations.last else { return }
        manager.distanceFilter = kCLLocationAccuracyHundredMeters
        print("Current location update - \(locationToDatabase)")
        FirebaseDatabaseManager.shared.sendLocationToDatabase(with: locationToDatabase)
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    
    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        AlertHelper.showAlert(msg: error.localizedDescription)
//    }
}

//MARK:- Address routine
extension UserLocationService {
    
//    private func updateUserAddress(_ location: CLLocation?) {
//        guard let location = location else { return }
//
//        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (places, error) in
//            if let place = places?.first {
//                if let address = self?.makeAddressString(place: place) {
//                    self?.lastUserAddress = address
//                    self?.callBackUserLocationWasChanged?(address)
//                    //print("reverseGeocodeLocation address \(address)")
//                }
//            }
//        }
//    }
    
    private func makeAddressString(place: CLPlacemark) -> String {
        let items = [place.country, place.locality, place.thoroughfare, place.subThoroughfare].compactMap( { $0 })
        //print("makeAddressString \(items)")
        let address = items.joined(separator: ", ")
        return address
    }
}




