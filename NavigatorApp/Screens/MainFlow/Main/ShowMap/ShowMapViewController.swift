//
//  ShowMapViewController.swift
//  NavigatorApp
//
//  Created by MN on 01.03.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit
import MapKit

class ShowMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: ShowMapViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupMV()
//        setupAnnotations() // Annotations
    }
    
    func bind() {
        viewModel.updateView = { [weak self] route in
            guard let self = self else { return }
            self.updateView(with: route)
        }
    }
    
    func setupMV() {
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
    
    @objc private func backButtonTapped() {
        viewModel.getBack()
    }
    
    func setupAnnotations() {
        let annotations = viewModel.getAnnotations()
        mapView.addAnnotations(annotations)
    }
    
    private func updateView(with mapRoute: MKRoute) {
      mapView.addOverlay(mapRoute.polyline)
    }
}

extension ShowMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
         renderer.strokeColor = UIColor.blue
         return renderer
     }
}
