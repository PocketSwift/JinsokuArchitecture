//
//  AppEventsHandler.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 19/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class AppEventsHandler: AppEventsHandlerProtocol {
    
    var application: UIApplication { return UIApplication.shared }
	var rootCoordinator: Coordinator?
    
    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool {
		
		// setup keyboard Manager
		IQKeyboardManager.sharedManager().enable = true
		
		// setup RootCoordinator
		let navigationManager = NavigationManager()
		window?.rootViewController = navigationManager.currentNavController
		window?.rootViewController = navigationManager.currentNavController
		rootCoordinator = RootCoordinator(navigationManager: navigationManager)
		rootCoordinator?.start()
		window?.makeKeyAndVisible()

        return true
    }
    
    func willResignActive() {
    }
    
    func didEnterBackground() {
    }
    
    func willEnterForeground() {
    }
    
    func didBecomeActive() {
    }
    
    func willTerminate() {
    }
    
    func beginIgnoringInteractionEvents() {
        application.beginIgnoringInteractionEvents()
    }
    
    func endIgnoringInteractionEvents() {
        application.endIgnoringInteractionEvents()
    }
    
}
