//
//  FirebaseDatabaseManager.swift
//  NavigatorApp
//
//  Created by MN on 22.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation


class FirebaseDatabaseManager {
    
    static let shared = FirebaseDatabaseManager()
    
    private init() {}
    
    
    private let database = Database.database().reference()
    
    
    
    
    
    func sendLocationToDatabase(with location: CLLocation) {
        guard let badEmail = UserDefaults.standard.value(forKey: "email") else { return }
        
        let email = replaceEmail(email: badEmail as! String)
        
//        let email = replaceEmail(email: "test@gmail.com")
        
        let arrayToSave: [Double] = [location.coordinate.latitude, location.coordinate.longitude]
    
        
        database.child(email).setValue(arrayToSave)
    }
    
    func replaceEmail(email: String) -> String {
        var replacingEmail = email.replacingOccurrences(of: ".", with: ",")
        replacingEmail = replacingEmail.replacingOccurrences(of: "@", with: "-")
        return replacingEmail
    }
    
    
    
    
}
