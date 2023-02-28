//
//  Typealias.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import Firebase


typealias EmptyClosure = () -> ()
typealias SimpleClosure<T> = (T) -> ()
typealias FirebaseRequestClosure<R: AuthDataResult, E: Error> = (_ result: (Result<R, E>)) -> ()
typealias DoubleSimpleClosure<T, A> = (T, A) -> ()
