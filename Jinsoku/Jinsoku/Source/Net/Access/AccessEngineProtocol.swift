//
//  AccessEngineProtocol.swift
//  Jinsoku
//
//  Created by Jose Antonio Garcia Yañez on 1/2/18.
//  Copyright © 2018 PocketSwift. All rights reserved.
//

import Foundation
import Result
import Kommander

protocol AccessEngineProtocol {
    func login(params: AccessLogin, completion: @escaping ((Result<AuthenticationNet, LoginError>) -> Void)) -> Kommand<Int>
}
