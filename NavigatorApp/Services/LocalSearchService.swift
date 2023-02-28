//
//  LocalSearchService.swift
//  NavigatorApp
//
//  Created by MN on 23.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import MapKit


protocol LocalSearchServiceType: Service {
//    var callBackUserAddressWasChanged: SimpleClosure<String>? { get set }
//
//    var callBack
    var callBackRequestDataChanged: SimpleClosure<[MKLocalSearchCompletion]>? { get set }
    
    
}




class LocalSearchService: NSObject, LocalSearchServiceType {
    var callBackRequestDataChanged: SimpleClosure<[MKLocalSearchCompletion]>?
    
    
    
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    var searchResults: [MKLocalSearchCompletion] = []
    
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        
    }
    
    func getDataForRequest(text: String) {
        searchCompleter.queryFragment = text
    }
    
}

extension LocalSearchService: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        searchResults = completer.results
        callBackRequestDataChanged?(completer.results)
        
        //TableView reloadData
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    
}
