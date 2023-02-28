//
//  ServiceHolder.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation

public protocol Service {}
public protocol InitializableService: Service {
    init()
}

public class ServiceHolder {
    private var servicesDictionary: [String: Service] = [:]
    
    /*public func add<T>(_ protocolType: T.Type, for concreteType: InitializableService.Type, with name: String? = nil) {
        self.add(protocolType, for: concreteType.init(), with: name)
    }

    public func add<T>(_ type: T.Type, with name: String? = nil, constructor: () -> Service) {
        self.add(type, for: constructor(), with: name)
    }
    
    public func add<T>(_ protocolType: T.Type, for instance: Service, with name: String? = nil) {
        let name = name ?? String(reflecting: protocolType)
        servicesDictionary[name] = instance
    }*/
    
    func add<T>(_ protocolType: T.Type, for instance: Service) {
        let name = String(reflecting: protocolType)
        servicesDictionary[name] = instance
    }

    func get<T>(by type: T.Type = T.self) -> T {
        return get(by: String(reflecting: type))
    }
    
    private func get<T>(by name: String) -> T {
        guard let service = servicesDictionary[name] as? T else {
            fatalError("firstly you have to add the service")
        }
        return service
    }
    
    func remove<T>(by type: T.Type) {
        let name = String(reflecting: type)
        if let _ = servicesDictionary[name] as? T {
            servicesDictionary[name] = nil
        }
    }
    
}
