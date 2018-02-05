import Foundation
import PocketNet
import Kommander
import Result

protocol AccessLoginDelegate: class {
    func loginResult() -> Result<AuthenticationNet, LoginError>
}

class AccessEngine: AccessEngineProtocol {
    
    enum Headers {
        static let acceptApplicationJson = ["Accept": "application/json"]
    }
    
    private let netSupport: NetSupport
    private let api: Api
    private let kommander = Kommander()
    private var loginState = String(Random.Digits.nine.random())
    private weak var delegate: AccessLoginDelegate?
    
    init(netSupport: NetSupport, api: Api) {
        self.netSupport = netSupport
        self.api = api
    }
    
    func loginURL() -> URL? {
        loginState = String(Random.Digits.nine.random())
        var methodUrl = String(format: api.oauth)
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: "client_id", value: "150f5bb8a92fcdbfa8af1aec91484e596acdd524")
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: "response_type", value: "code")
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: "redirect_uri", value: "vimeo150f5bb8a92fcdbfa8af1aec91484e596acdd524://auth")
        methodUrl = URLQueryParamsHelper.addOrUpdateQueryStringParameter(url: methodUrl, key: "state", value: loginState)
        return URL(string: methodUrl)
    }
    
    func continueLoginOAuth(with state: String, and code: String) {
        guard state == loginState else { return }
        //TODO: POST!
    }
    
}
