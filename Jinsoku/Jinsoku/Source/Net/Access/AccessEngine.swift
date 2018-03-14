import Foundation
import PocketNet

protocol AccessLoginDelegate: class {
    func loginResult(_ loginResult: Result<AuthenticationNet, LoginError>)
}

class AccessEngine: AccessEngineProtocol {
    
    enum Headers {
        static let acceptApplicationJson = ["Accept": "application/json"]
    }
    
    struct Keys {
        static let clientId = "client_id"
        static let responseType = "response_type"
        static let responseTypeCode = "code"
        static let redirectUri = "redirect_uri"
        static let state = "state"
    }
    
    private let netSupport: NetSupport
    private let api: Api
    private var loginState = String(Random.Digits.nine.random())
    private weak var delegate: AccessLoginDelegate?
    
    init(netSupport: NetSupport, api: Api) {
        self.netSupport = netSupport
        self.api = api
    }
    
    func loginURL(delegate: AccessLoginDelegate) throws -> URL {
        let accessTokenIntern = try AccessTokenIntern(redirectUri: KNet.Auth.redirectUri) ~> LoginError.noVimeoAuthenticationPlist
        self.delegate = delegate
        loginState = String(Random.Digits.nine.random())
        var methodUrl = String(format: api.authorize)
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: Keys.clientId, value: accessTokenIntern.clientIdentifier)
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: Keys.responseType, value: Keys.responseTypeCode)
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: Keys.redirectUri, value: accessTokenIntern.redirectUri)
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: Keys.state, value: loginState)
        guard let url = URL(string: methodUrl) else { throw LoginError.badURLCreation }
        return url
    }
    
    func continueLoginOAuth(with state: String, and code: String) {
        guard state == loginState else { return }
    
        let methodUrl = String(format: api.accessToken)
        guard let accessTokenIntern = try? AccessTokenIntern(code: code, redirectUri: KNet.Auth.redirectUri) else { return }
        
        let request = NetRequest.Builder()
            .method(.post)
            .url(methodUrl)
            .requestHeader(accessTokenIntern.authHeader)
            .parameterEncoding(.json)
            .body(params: accessTokenIntern.getJSONString())
            .build()
        
        _ = self.netSupport.netJsonMappableRequest(request, completion: {(result: PocketResult<AuthenticationNet, NetError>) in
            switch result {
            case .success(let authenticationNet):
                DispatchQueue.main.async { self.delegate?.loginResult(Result.success(authenticationNet)) }
            case .failure(let netError):
                switch netError {
                case .noConnection:
                    DispatchQueue.main.async { self.delegate?.loginResult(Result.failure(.noConnection)) }
                default:
                    DispatchQueue.main.async { self.delegate?.loginResult(Result.failure(.responseProblems)) }
                }
            }
        })
        
    }
    
}
