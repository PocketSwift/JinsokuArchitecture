//
//  AuthenticationTransformer.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation

struct AuthenticationTransformer {
    
    static func transform(from authenticationNet: AuthenticationNet) -> Authentication? {
        return Authentication.Builder()
            .setToken(authenticationNet.token)
            .build()
    }
    
}


