//
//  ProgressHudService.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import JGProgressHUD

class ProgressHudService: Service {
    
    let loading = JGProgressHUD(style: .dark)
    
    func progressViewActivate(view: UIView) {
        loading.show(in: view, animated: true)
    }
    
    func progressViewDisable() {
        loading.dismiss()
    }
    
    
    
}
