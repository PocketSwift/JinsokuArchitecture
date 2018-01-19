//
//  AppEventsHandler.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 19/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import UIKit

class AppEventsHandler: AppEventsHandlerProtocol {
    
    var application: UIApplication { return UIApplication.shared }
    
    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool {
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
