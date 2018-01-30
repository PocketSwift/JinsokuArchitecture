//
//  VimeoNet.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation
import PocketNet

class VimeoNet {
    fileprivate static let netSupport = NetSupport(net: PocketNetAlamofire())
}

extension VimeoNet {
    static let access = AccessEngine(netSupport: VimeoNet.netSupport, api: Api(baseUrl: "baseURL"))
}
