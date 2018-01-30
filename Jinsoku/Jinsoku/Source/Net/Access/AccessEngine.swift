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

class AccessEngine {
    
    private let netSupport: NetSupport
    private let api: Api
    private let kommander = Kommander()
    
    init(netSupport: NetSupport, api: Api) {
        self.netSupport = netSupport
        self.api = api
    }
    
    public func login(params: AccessLogin, completion: @escaping ((Result<Authentication, LoginError>) -> Void)) -> Kommand<Int> {
        return kommander.makeKommand {
            
            let methodUrl = String(format: self.api.example)
            let dicHeader = ["Accept": "application/json"]
            
            let request = NetRequest.Builder()
                .method(.post)
                .url(methodUrl)
                .requestHeader(dicHeader)
                .parameterEncoding(.json)
                .body(params: params.toJSONString())
                .build()
            
            return self.netSupport.netJsonMappableRequest(request, completion: {(result: Result<AuthenticationNet, NetError>) in
                switch result {
                case .success(let authenticationNet):
                    do {
                        let authentication: Authentication = try AccessParser.parseAuthentication(authenticationNet)
                        DispatchQueue.main.async { completion(Result.success(authentication)) }
                    } catch {
                        DispatchQueue.main.async { completion(Result.failure(.responseProblems)) }
                    }
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
