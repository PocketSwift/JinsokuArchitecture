//
//  AccessErrors.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 30/1/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation

public enum LoginError: Error {
    case responseProblems
    case noConnection
    case badCredentials
}
