//
//  NetworkService.swift
//  NavigatorApp
//
//  Created by MN on 28.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation


class NetworkService: Service {
    
    
    
    var startTracking: Bool = false
//    var userDataModels: UserDataType = [:]
    var userModels: [UserData] = []
    
    
//    func doesUserHaveData() -> Bool {
//
//
//        let result = FirebaseDatabaseManager.shared.doesUserHaveData { bool in
//            return bool
//        }
//    }
    
    func fetchData(completion: @escaping SimpleClosure<[UserData]>) {
        
        FirebaseDatabaseManager.shared.fetchFromDatabase { [weak self] userData in
            guard let self = self else { return }
            
            
            var arrayToSave: [UserData] = []
            
//            self.userDataModels = userData
            
            for i in userData {
                
                guard let first = i.value.first, let last = i.value.last else { return }
                
//                var new = UserData(date: [i.key : [Coordinates(lat: first, lon: last)]])
                let new = UserData(dateString: i.key, lat: first, lon: last)
//                self.userModels.append(new)
                arrayToSave.append(new)
                
            }
            
            self.userModels = arrayToSave
            completion(self.userModels)
        }
    }
}
