//
//  URL+QueryParams.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 5/2/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation

extension URL {
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
}
