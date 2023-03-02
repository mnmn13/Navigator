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
    
    func replaceEmail(email: String) -> String {
        var replacingEmail = email.replacingOccurrences(of: ".", with: ",")
        replacingEmail = replacingEmail.replacingOccurrences(of: "@", with: "-")
        return replacingEmail
    }
    
    func sendLocationToDatabase(with location: CLLocation) {
        guard let badEmail = UserDefaults.standard.value(forKey: "email") else { return }
        
        let email = replaceEmail(email: badEmail as! String)
//        let email = replaceEmail(email: "test@gmail.com")
        
        let arrayToSave: [Double] = [location.coordinate.latitude, location.coordinate.longitude]
        let dateToSave = Time.dateToString(date: Date())

        database.child("Users").child(email).child(dateToSave).setValue(arrayToSave)
        
        fetchFromDatabase { array in
            print("ArrayFROMDATABASE - \(array)")
        }
    }
        
    func fetchFromDatabase(completion: @escaping SimpleClosure<UserDataType>) {
        guard let badEmail = UserDefaults.standard.value(forKey: "email") else { return }
        let email = replaceEmail(email: badEmail as! String)

        database.child("Users").child(email).observeSingleEvent(of: .value) { snapshot in
            guard let result = snapshot.value as? UserDataType else { return }
            completion(result)
        }
    }
    
//    func doesUserHaveData(completion: @escaping SimpleClosure<Bool>) {
//        guard let badEmail = UserDefaults.standard.value(forKey: "email") else { return }
//
//        let email = replaceEmail(email: badEmail as! String)
//
//        database.child(email).observeSingleEvent(of: .value) { snapshot in
//            guard let result = snapshot.value else { completion(false); return}
//
//            completion(true)
//        }
//    }
    
    func clearBaseForCurrentUser() {
        guard let badEmail = UserDefaults.standard.value(forKey: "email") else { return }

        let email = replaceEmail(email: badEmail as! String)
        
        database.child("Users").child(email).removeValue()
        print("Database cleared")
    }
}
