//
//  SearchViewModel.swift
//  NavigatorApp
//
//  Created by MN on 22.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import MapKit



struct SearchViewModel {
    
    
    var searchResults: [MKLocalSearchCompletion]
    
    init(searchModels: [MKLocalSearchCompletion]) {
        self.searchResults = searchModels
    }
    
}
