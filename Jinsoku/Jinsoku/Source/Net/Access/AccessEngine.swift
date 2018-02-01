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
import Result

class AccessEngine: AccessEngineProtocol {
    
    enum Headers {
        static let acceptApplicationJson = ["Accept": "application/json"]
    }
    
    private let netSupport: NetSupport
    private let api: Api
    private let kommander = Kommander()
    
    init(netSupport: NetSupport, api: Api) {
        self.netSupport = netSupport
        self.api = api
    }
    
    public func login(params: AccessLogin, completion: @escaping ((Result<AuthenticationNet, LoginError>) -> Void)) -> Kommand<Int> {
        return kommander.makeKommand {
            
            let request = NetRequest.Builder()
                .url(self.api.example)
                .method(.post)
                .requestHeader(Headers.acceptApplicationJson)
                .parameterEncoding(.json)
                .body(params: params.toJSONString())
                .build()
            
            return self.netSupport.netJsonMappableRequest(request, completion: {(result: Result<AuthenticationNet, NetError>) in
                switch result {
                case .success(let authenticationNet):
                    DispatchQueue.main.async {completion(Result.success(authenticationNet)) }
                case .failure(let netError):
                    switch netError {
                    case .error(let statusErrorCode, _):
                        switch statusErrorCode {
                        case 510:
                            DispatchQueue.main.async { completion(Result.failure(.responseProblems)) }
                        case 412:
                            DispatchQueue.main.async { completion(Result.failure(.badCredentials)) }
                        default:
                            DispatchQueue.main.async { completion(Result.failure(.responseProblems)) }
                        }
                    case .noConnection:
                        DispatchQueue.main.async { completion(Result.failure(.noConnection)) }
                    default:
                        DispatchQueue.main.async { completion(Result.failure(.responseProblems)) }
                    }
                }
            })
        }
    }
    
}
