//
//  ShowMapViewModel.swift
//  NavigatorApp
//
//  Created by MN on 01.03.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import MapKit

protocol ShowMapViewModelType: AnyObject {
    
    //Binds
    var updateView: SimpleClosure<MKRoute>? { get set }
    
    //Annotation
    func getAnnotations() -> [MKPointAnnotation]
    
    //Navigation
    func getBack()
}

class ShowMapViewModel: ShowMapViewModelType {
    
    fileprivate let coordinator: MainCoordinatorType
//    private var locationService: UserLocationService
//    private let networkService: NetworkService
    private var userData: [UserData]
//    private var points: [CLLocationCoordinate2D]
    private var mapItems: [MKMapItem]
    
    var updateView: SimpleClosure<MKRoute>?
    
    
    init(coordinator: MainCoordinatorType, serviceHolder: ServiceHolder, userData: [UserData]) {
        self.coordinator = coordinator
//        self.locationService = serviceHolder.get()
//        self.networkService = serviceHolder.get()
        self.userData = userData
//        self.points = userData.compactMap { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon) }
        self.mapItems = userData.compactMap { MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon)))}
        fetchNextRoute()
    }
    
    func getAnnotations() -> [MKPointAnnotation] {
        
        var annotations: [MKPointAnnotation] = []
        
        for i in userData {
            
            let lat = i.lat
            let lon = i.lon

            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)

            annotations.append(annotation)
        }
        return annotations
    }
    
    private func fetchNextRoute() {
        guard !mapItems.isEmpty, mapItems.count != 1 else { return }
        
        let request = MKDirections.Request()
        
        request.source = mapItems.first
        request.destination = mapItems[1]
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }
            guard let mapRoute = response?.routes.first else {
                print(error?.localizedDescription as Any)
                return
            }
            self.mapItems.removeFirst()
            self.updateView?(mapRoute)
            self.fetchNextRoute()
        }
    }
    
    func getBack() {
        coordinator.getBack()
    }
}
