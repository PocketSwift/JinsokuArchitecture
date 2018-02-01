//
//  Authentication+Net.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 1/2/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation

extension Authentication {
    
    init?(authenticationNet: AuthenticationNet) {
        guard let authentication = Authentication.Builder()
            .setToken(authenticationNet.token)
            .build()
            else { return nil }
        self = authentication
    }
    
}
