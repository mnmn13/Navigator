//
//  MainViewModel.swift
//  NavigatorApp
//
//  Created by MN on 28.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

protocol MainViewModelType: AnyObject {
    
    var onReload: EmptyClosure? { get set }
    
    func loadInfo()
    func fetchFromDatabase()
    
    //TableView
    func getNumberOfSections() -> Int
    func getNumberOfRowsInSection() -> Int
    func getCellForRowAt(indexPath: IndexPath) -> UserData
    
    //Navigation
    func showMap()
    func logout()
    
    //Monitoring Buttons
    func startMonitor() -> String
    func stopMonitor() -> String
    
    //ActionButtons
    func eraseDataBase() -> String
    
}

class MainViewModel: MainViewModelType {
    
    fileprivate let coordinator: MainCoordinatorType
    private var locationService: UserLocationService
//    private let localSearchService: LocalSearchService
//    private let serviceHolder: ServiceHolder
    private let networkService: NetworkService
    
    private var userData: [UserData] = []
    
    var onReload: EmptyClosure?
    
    
    init(coordinator: MainCoordinatorType, serviceHolder: ServiceHolder) {
        self.coordinator = coordinator
        self.locationService = serviceHolder.get()
//        self.localSearchService = serviceHolder.get()
        self.networkService = serviceHolder.get()
//        self.serviceHolder = serviceHolder
    }
    
    deinit {
        print("\(type(of: self)) \(#function)")
    }
    
    func loadInfo() {
//        networkService.fetchData()
    }
    
    func fetchFromDatabase() {
        networkService.fetchData { [weak self] userData in
            guard let self = self else { return }
            self.userData = userData.sorted(by: { $0.date < $1.date } )
            self.onReload?()
        }
    }
    
    //MARK: TableView
    func getNumberOfSections() -> Int {
        if userData.isEmpty {
            return 0
        } else {
            return 1
        }
    }
    
    func getNumberOfRowsInSection() -> Int {
        if userData.isEmpty {
            return 0
        } else {
            return userData.count
        }
    }
    
    func getCellForRowAt(indexPath: IndexPath) -> UserData {
        
        if userData.isEmpty {
            return UserData(dateString: "nil", lat: 0, lon: 0)
        } else {
            let userdataModel = userData[indexPath.item]
            return userdataModel
        }
    }
    
    //MARK: - ActionButtons
    func showMap() {
        coordinator.showMap(with: self.userData)
    }
    
    func startMonitor() -> String {
        
        if networkService.startTracking {
            
            return "Monitoring already started"
        } else {
            locationService.startStopMonitoring?(true)
            networkService.startTracking = true
            fetchFromDatabase()
            return "Monitoring started"
        }
    }
    
    func stopMonitor() -> String {
        if networkService.startTracking {
            locationService.startStopMonitoring?(false)
            networkService.startTracking = false
            return "Monitoring stopped"
        } else {
            return "Monitoring is already stopped"
        }
    }
    
    func eraseDataBase() -> String {
        FirebaseDatabaseManager.shared.clearBaseForCurrentUser()
        return "Database erased"
    }
    
    func logout() {
        coordinator.logout()
        UserDefaults.standard.isLoggedIn = false
    }
}
