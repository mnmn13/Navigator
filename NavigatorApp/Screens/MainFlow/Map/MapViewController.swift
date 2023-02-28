//
//  MapViewController.swift
//  NavigatorApp
//
//  Created by MN on 27.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AVFoundation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var searchController: UISearchController!
    
    var searchResultVController: UIViewController!
    
    var viewModel: MapViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        setupSearchController()
    }
    
    func bind() {
        viewModel.sendItem = { [weak self] route, circles in
            guard let self = self else { return }
            self.mapView.addOverlay(route.polyline)
            
            for i in circles {
                self.mapView.addOverlay(i)
            }
        }
    }
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: searchResultVController)
        
        searchController.searchBar.tintColor = .white
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 10
            return renderer
        }
        
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.strokeColor = .orange
            renderer.fillColor = .red
            renderer.alpha = 0.5
            return renderer
        }
        
        return MKOverlayRenderer()
    }
}

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        
        viewModel.sendDataToBeSearch(text: text)
    }
}
