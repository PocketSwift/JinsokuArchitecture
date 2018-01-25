//
//  BaseCoordinator.swift
//  ViperDemo
//
//  Created by Megdadi, Omar on 15/01/2018.
//  Copyright © 2018 GFT. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var navigationManager: NavigationManagerProtocol { get }
    var childCoordinators: [Coordinator] { get }
    var finishFlow: (() -> Void)? { get set }
    
    init(navigationManager: NavigationManagerProtocol)
    func add(childCoordinator coordinator: Coordinator)
    func remove(childCoordinator coordinator: Coordinator?)
    func start()
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationManager: NavigationManagerProtocol
    var finishFlow: (() -> Void)?
    
    required init(navigationManager: NavigationManagerProtocol) {
        self.navigationManager = navigationManager
    }
    
    func add(childCoordinator coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {return}
        childCoordinators.append(coordinator)
    }
    
    func remove(childCoordinator coordinator: Coordinator?) {
        childCoordinators = childCoordinators.filter {
            let aux = ($0 !== coordinator)
            print(aux ? "se queda \($0.self)": "se va \($0.self)")
            return aux
        }
        print(childCoordinators.description)
    }
    
    func start() {
        fatalError("Must Override")
    }

}
