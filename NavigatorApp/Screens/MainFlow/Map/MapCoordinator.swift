//
//  MapCoordinator.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

protocol MapCoordinatorTransitions: AnyObject {}

protocol MapCoordinatorType {}

class MapCoordinator: MapCoordinatorType {
    
    private let serviceHolder: ServiceHolder
    private weak var navigationController: UINavigationController?
    private weak var transitions: MapCoordinatorTransitions?
    private weak var controller = Storyboard.map.controller(withClass: MapViewController.self)
    private weak var controller2 = Storyboard.search.controller(withClass: SearchViewController.self)
    
    init(serviceHolder: ServiceHolder, navigationController: UINavigationController?, transitions: MapCoordinatorTransitions?) {
        self.serviceHolder = serviceHolder
        self.navigationController = navigationController
        self.transitions = transitions
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }

    func start() {
        
        if let controller = controller {
            let viewModel = MapViewModel(coordinator: self, serviceHolder: serviceHolder)
            
            controller.viewModel = viewModel
            
            guard let searchVC = controller2 else { return }
            searchVC.mapViewModel = viewModel
            
            controller.searchResultVController = searchVC
            
            navigationController?.setViewControllers([controller], animated: true)
        }
    }
}
