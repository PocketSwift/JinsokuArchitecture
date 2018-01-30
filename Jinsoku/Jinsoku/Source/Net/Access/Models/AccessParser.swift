//
//  AccessParser.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation

struct AccessParser {
    
    static func parseAuthentication(_ authenticationNet: AuthenticationNet) throws -> Authentication {
        guard let authentication = AuthenticationTransformer.transform(from: authenticationNet) else {
            throw LoginError.responseProblems
        }
        return authentication
    }
    
}
