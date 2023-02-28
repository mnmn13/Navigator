//
//  SearchViewController.swift
//  NavigatorApp
//
//  Created by MN on 22.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class SearchViewController: UITableViewController {
    
//    @IBOutlet weak var tableView: UITableView!
    
    var mapViewModel: MapViewModelType!
    
//    var searchResults: [MKLocalSearchCompletion]? {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupUI()
    }
    
    private func bind() {
        mapViewModel.onReload = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    
    
    
    func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    
    
}

extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        mapViewModel.getNumberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mapViewModel.getNumberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResult = mapViewModel.getCellForRowAt(indexPath: indexPath)
        
//        let searchResult = searchResults?[indexPath.row]
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: .none)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = searchResult.title
        cell.contentConfiguration = content
        

        return cell
        
    }
    
    
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        mapViewModel.itemTapped(indexPath: indexPath)
        
//        
//        guard let result = searchResults?[indexPath.row] else { return }
////        let result = searchResults?[indexPath.row]
//        let searchRequest = MKLocalSearch.Request(completion: result)
//        
//        let search = MKLocalSearch(request: searchRequest)
//        search.start { (response, error) in
//            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
//                return
//            }
//            
//            guard let name = response?.mapItems[0].name else {
//                return
//            }
//            
//            print(name)
//            
//            let lat = coordinate.latitude
//            let lon = coordinate.longitude
//            
//            print(lat)
//            print(lon)
//            
//        }
    }
    
}
