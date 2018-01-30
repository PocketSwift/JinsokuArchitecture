//
//  AccessEngine.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation
import PocketNet
import Kommander

class AccessEngine {
    
    private let netSupport: NetSupport
    private let api: Api
    private let kommander = Kommander()
    
    init(netSupport: NetSupport, api: Api) {
        self.netSupport = netSupport
        self.api = api
    }
    
}
