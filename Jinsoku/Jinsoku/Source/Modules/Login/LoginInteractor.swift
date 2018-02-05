import UIKit
import Result

class LoginInteractor: LoginInteractorProtocol {
    
    func login() {
        guard let loginURL = VimeoNet.access.loginURL(delegate: self) else { return }
        AppProvider.appEventsHandler.openURL(loginURL, options: [:], completionHandler: nil)
    }
	
}

extension LoginInteractor: AccessLoginDelegate {
    
    func loginResult(_ loginResult: Result<AuthenticationNet, LoginError>) {
        switch loginResult {
        case .success(let authenticationNet):
            break
        case .failure:
            break
        }
    }
    
}
