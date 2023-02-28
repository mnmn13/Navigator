//
//  SignUpViewModel.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpViewModelType {
    var onReload: EmptyClosure? { get set }
    
    //actions
    func validate(email: String?, password1: String?, password2: String?, view: UIView) -> String
//    func register(email: String, password: String, completion: @escaping SimpleClosure<String>)
    func signIn()
}


class SignUpViewModel: SignUpViewModelType {
    
    var onReload: EmptyClosure?
    
    fileprivate let coordinator: SignUpCoordinatorType
    private var userService: UserService
    private var progressHudService: ProgressHudService
    
    init(coordinator: SignUpCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.userService = serviceHolder.get()
        self.progressHudService = serviceHolder.get()
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    //actions
    func validate(email: String?, password1: String?, password2: String?, view: UIView) -> String {
        
        guard let email = email, !email.isEmpty else { return "Incorrect email" }
        guard let pass = password1, !pass.isEmpty, pass.count >= 6 else { return "Incorrect password" }
        guard let pass2 = password2, !pass2.isEmpty, pass2 == pass else { return "Passwords do not match"}
        let alert: String = register(email: email, password: pass2, view: view)
        return alert
    }
    
    func register(email: String, password: String, view: UIView) -> String {
        var alertMassage = ""
        progressHudService.progressViewActivate(view: view)
        
        userService.signUp(with: email, and: password) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.progressHudService.progressViewDisable()
                self.coordinator.userDidRegister()
            case .failure(let error):
                self.progressHudService.progressViewDisable()
                print(error.localizedDescription)
                alertMassage = "Error - user not regidtered"
            }
        }
        
//        userService.signIn(with: email, and: password) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(_):
//                self.progressHudService.progressViewDisable()
//                self.coordinator.userDidRegister()
//            case .failure(let error):
//                self.progressHudService.progressViewDisable()
//                print(error.localizedDescription)
//                alertMassage = "Incorrect email or password"
//            }
//        }
        return alertMassage
    }
    func signIn() {
        
    }
    
    
    
    
    
    
}
