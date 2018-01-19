//
//  AppEventsHandlerProtocol.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 19/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import UIKit

public protocol AppEventsHandlerProtocol {

    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool
    
    func willResignActive()
    
    func didEnterBackground()
    
    func willEnterForeground()
    
    func didBecomeActive()
    
    func willTerminate()
    
    func beginIgnoringInteractionEvents()
    
    func endIgnoringInteractionEvents()
    
}
