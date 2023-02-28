//
//  UserService.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import Firebase


protocol UserServiceType: Service {
    
}


class UserService: UserServiceType {

    func signIn(with email: String, and password: String, completion: @escaping FirebaseRequestClosure<AuthDataResult, Error>) {
        
        Firebase.Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                completion(.failure(error!))
            }
            
            guard let result = authResult else { return }
            completion(.success(result))
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.isLoggedIn = true
        }
    }
    
    func signUp(with email: String, and password: String, completion: @escaping FirebaseRequestClosure<AuthDataResult, Error>) {
        
        Firebase.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if error != nil {
                completion(.failure(error.unsafelyUnwrapped))
            }
            
            guard let result = authResult else { return }
            completion(.success(result))
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.isLoggedIn = true
        }
    }
    
    func didAuthorized() -> Bool {
        var result = true
        if Firebase.Auth.auth().currentUser == nil {
            result = false
        }
        return result
    }
}

