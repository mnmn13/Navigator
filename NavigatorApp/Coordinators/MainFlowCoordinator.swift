//
//  MainFlowCoordinator.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

protocol MainFlowCoordinatorTransitions: AnyObject {
    func logout()
}

protocol MainFlowCoordinatorType {
    
}

class MainFlowCoordinator {
    
    let serviceHolder: ServiceHolder
    private let window: UIWindow
    private let rootNav: UINavigationController = UINavigationController()
    private weak var transitions: MainFlowCoordinatorTransitions?
    private weak var mainController = Storyboard.map.controller(withClass: MapViewController.self)
    
    init(window: UIWindow, transitions: MainFlowCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.window = window
        self.transitions = transitions
        self.serviceHolder = serviceHolder
    }
    
    func start() {
        
        let coordinator = MapCoordinator(serviceHolder: serviceHolder, navigationController: rootNav, transitions: self)
        coordinator.start()

            window.rootViewController = rootNav
            window.makeKeyAndVisible()
//        }
    }
}

extension MainFlowCoordinator: MainFlowCoordinatorType {

    
}

extension MainFlowCoordinator: MapCoordinatorTransitions {
    
}


