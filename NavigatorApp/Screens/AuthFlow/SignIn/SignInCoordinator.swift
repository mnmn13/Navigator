//
//  SignInCoordinator.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

protocol SignInCoordinatorTransitions: AnyObject {
    
    func userDidLogin()
    func signUp()
    func startWithoutLogin()
}

protocol SignInCoordinatorType {
 
    func userDidLogin()
    func signUp()
    func startWithoutLogin()
}

class SignInCoordinator: SignInCoordinatorType {
    
    private weak var navigationController: UINavigationController?
    private weak var transitions: SignInCoordinatorTransitions?
    private weak var controller = Storyboard.auth.controller(withClass: SignInViewController.self)
    private var serviceHolder: ServiceHolder
    
    
    
//    private var serviceHolder: ServiceHolder
    
    init(navigationController: UINavigationController?, transitions: SignInCoordinatorTransitions?, serviceHolder: ServiceHolder) {
        self.navigationController = navigationController
        self.transitions = transitions
        self.serviceHolder = serviceHolder

        controller?.viewModel = SignInViewModel(coordinator: self, serviceHolder: self.serviceHolder)
        
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func start() {
        if let controller = controller {
            navigationController?.setViewControllers([controller], animated: false)
        }
    }
    
    func userDidLogin() {
        transitions?.userDidLogin()
    }
    
    func signUp() {
        transitions?.signUp()
    }
    
    func startWithoutLogin() {
        transitions?.startWithoutLogin()
    }
}
