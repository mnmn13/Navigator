//
//  UIStoryboardExtensions.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import UIKit

struct Storyboard {
    static let auth = UIStoryboard(name: "Auth", bundle: nil)
    static let map = UIStoryboard(name: "Map", bundle: nil)
    static let search = UIStoryboard(name: "Search", bundle: nil)
    static let main = UIStoryboard(name: "Main", bundle: nil)
    static let showMap = UIStoryboard(name: "ShowMap", bundle: nil)
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self.self)
    }
}

extension UIStoryboard {
    
    func controller<T: UIViewController>(withClass: T.Type) -> T? {
        let identifier = withClass.identifier
        return instantiateViewController(withIdentifier: identifier) as? T
    }
    
    func instantiateViewController<T: StoryboardIdentifiable>() -> T? {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
}

extension UIViewController: StoryboardIdentifiable { }


