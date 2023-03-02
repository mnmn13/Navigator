//
//  MapViewModel.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


protocol MapViewModelType {
    
    var onReload: EmptyClosure? { get set }
    var sendItem: DoubleSimpleClosure<MKRoute, [MKCircle]>? { get set }
    
    //TableView
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection() -> Int
    func getCellForRowAt(indexPath: IndexPath) -> MKLocalSearchCompletion
    func itemTapped(indexPath: IndexPath)
    
    func sendDataToBeSearch(text: String?)

    func getDirection(completion: @escaping DoubleSimpleClosure<MKRoute, [MKCircle]>)
//    var localSearchRersponse: MKLocalSearch.Response? { get set }
}

class MapViewModel: MapViewModelType {
    
    var onReload: EmptyClosure?
    
    var searchResults = [MKLocalSearchCompletion]()
    
    var sendItem: DoubleSimpleClosure<MKRoute, [MKCircle]>?
    
    fileprivate let coordinator: MapCoordinatorType
//    private var locationService: UserLocationService
    private let localSearchService: LocalSearchService
//    private let serviceHolder: ServiceHolder
    
    internal var localSearchRersponse: MKLocalSearch.Response?
    internal var userLocation: CLLocationCoordinate2D?
    
    init(coordinator: MapCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
//        self.locationService = serviceHolder.get()
        self.localSearchService = serviceHolder.get()
//        self.serviceHolder = serviceHolder
        callBackRequestData()
        callBackUserLocation()
    }
    
    private var userLocationService: UserLocationServiceType = UserLocationService()
    
    private func callBackRequestData() {
        localSearchService.callBackRequestDataChanged = { [weak self] results in
            guard let self = self else { return }
            self.searchResults = results
            self.onReload?()
        }
    }
    
    private func callBackUserLocation() {
        userLocationService.callBackUserLocationWasChanged = { [weak self] location in
            guard let self = self else { return }
            self.userLocation = location
        }
    }
    
    func sendDataToBeSearch(text: String?) {
        
        guard let text = text, text != "" else { return }
        
        localSearchService.getDataForRequest(text: text)
    }
    
    //MARK: - TableViewSetup
    func getNumberOfSections() -> Int {
        if searchResults.isEmpty {
            return 0
        } else {
            return 1
        }
    }
    
    func getNumberOfRowsInSection() -> Int {
        if searchResults.isEmpty {
            return 0
        } else {
            return searchResults.count
        }
    }
    
    func getCellForRowAt(indexPath: IndexPath) -> MKLocalSearchCompletion {
        
        if searchResults.isEmpty {
            return MKLocalSearchCompletion()
        } else {
            let searchResult = searchResults[indexPath.row]
            return searchResult
        }
    }
    
    func itemTapped(indexPath: IndexPath) {
        
        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let self = self else { return }
            guard let coordinate = response?.mapItems[0].placemark.coordinate else { return }
            
            guard let name = response?.mapItems.first?.name else { return }
            
            self.localSearchRersponse = response
            
            print(name, coordinate.latitude, coordinate.longitude)
            
            self.getDirection { route, circles in
                self.sendItem?(route, circles)
            }
        }
    }
    
    //MARK: - Calculate directions
    func getDirection(completion: @escaping DoubleSimpleClosure<MKRoute, [MKCircle]>) {
        
        guard let userLocation = userLocation else { return }
        guard let localSearchRersponse = localSearchRersponse?.mapItems.first else { return }
        let sourseMapItem = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        let destinationMapItem = localSearchRersponse
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourseMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let fastestRoute = response?.routes.first else { return }
            
            var circles = [MKCircle]()
            
            for i in 0..<fastestRoute.steps.count {
                let step = fastestRoute.steps[i]
                print(step.instructions)
                print(step.distance)
                let region = CLCircularRegion(center: step.polyline.coordinate, radius: 20, identifier: "\(i)")
                
                
                let circle = MKCircle(center: region.center, radius: region.radius)
                circles.append(circle)
            }
            completion(fastestRoute, circles)
        }
    }
}
