//
//  SignInViewModel.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

protocol SignInViewModelType {
    
    var onReload: EmptyClosure? { get set }
    //getters
    //    var setUpTitle: NSAttributedString { get }
    
    //actions
//    func validate(email: String, password: String) -> String?
    //    func login(email: String, password: String, view: UIView)
    func validate(email: String?, password: String?, view: UIView) -> String
    func signUp()
    func testLogin()
    func startWithoutLogin()
}

class SignInViewModel: SignInViewModelType {
    
    var onReload: EmptyClosure?
    
    fileprivate let coordinator: SignInCoordinatorType
    private var userService: UserService
    private var progressHudService: ProgressHudService
    //    private var userService: UserServiceType
    
    init(coordinator: SignInCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.userService = serviceHolder.get()
        self.progressHudService = serviceHolder.get()
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    //getters
    //    var setUpTitle: NSAttributedString
    
    //actions
    func validate(email: String?, password: String?, view: UIView) -> String {
        
        guard let email = email, !email.isEmpty else { return "Incorrect email" }
        guard let pass = password, !pass.isEmpty, pass.count >= 6 else { return "Incorrect password" }
        let alert: String = login(email: email, password: pass, view: view)
        return alert
    }
    
    func login(email: String, password: String, view: UIView) -> String {
        var alertMassage = ""
        progressHudService.progressViewActivate(view: view)
        
        userService.signIn(with: email, and: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.progressHudService.progressViewDisable()
                self.coordinator.userDidLogin()
            case .failure(let error):
                self.progressHudService.progressViewDisable()
                print(error.localizedDescription)
                alertMassage = "\(error.localizedDescription)"
            }
        }
        return alertMassage
    }
    
    func signUp() {
        coordinator.signUp()
    }
    func testLogin() {
        coordinator.userDidLogin()
    }
    func startWithoutLogin() {
        coordinator.startWithoutLogin()
    }
    
    
    
}

