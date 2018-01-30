//
//  Authentication.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation

struct Authentication {
    
    let token: String
    
    private init?(builder: Builder) {
        guard let token = builder.token
            else { return nil }
        
        self.token = token
    }
    
    class Builder {
        
        var token: String?
        
        func setToken(_ token: String?) -> Builder {
            self.token = token
            return self
        }
        
        func build() -> Authentication? {
            return Authentication(builder: self)
        }
        
    }
    
}
