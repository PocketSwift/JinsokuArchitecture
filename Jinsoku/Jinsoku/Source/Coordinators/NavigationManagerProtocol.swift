//
//  NavigationManagerProtocol.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 14/3/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import UIKit

protocol NavigationManagerProtocol {
    
    // Navigation containers
    var currentNavController: UINavigationController? {get}
    var tabBarController: UITabBarController? {get}
    
    // Containers torages
    var navigationControllers: [UINavigationController] {get set}
    
    // Methods
    func setCurrentNavigationController(_ navigationController: Any?)
    func presentVC(_ viewController: Any?, animated: Bool, completion: (() -> Void)?)
    func dismissVC(animated: Bool, completion: (() -> Void)?)
    func pushVC(_ viewController: Any?, animated: Bool, backCompletion: (() -> Void)?)
    func popVC(animated: Bool)
    func popToRoot(animated: Bool)
    func setRootViewController(_ controller: Any?)
    func setRootViewController(_ controller: Any?, hideBar: Bool)
}
