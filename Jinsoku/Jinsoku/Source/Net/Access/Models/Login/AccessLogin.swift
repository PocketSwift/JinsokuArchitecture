//
//  AccessLogin.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation
import ObjectMapper

struct AccessLogin: Mappable {
    
    struct Keys {
        static let username = "username"
        static let password = "password"
    }
    
    let username: String
    let password: String
    
    init?(map: Map) {
        do {
            username = try map.value(Keys.username)
            password = try map.value(Keys.password)
        } catch { return nil }
    }
    
    func mapping(map: Map) {
        username >>> map[Keys.username]
        password >>> map[Keys.password]
    }
}
