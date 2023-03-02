//
//  UserDataModel.swift
//  NavigatorApp
//
//  Created by MN on 28.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

struct UserData {
    
    var dateString: String
    var date: Date { return Time.stringToDate(string: dateString) }
    var lat: Double
    var lon: Double
}

