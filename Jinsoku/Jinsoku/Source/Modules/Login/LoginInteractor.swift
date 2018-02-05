import UIKit
import Result

protocol LoginInteractorDelegate: class {
    func loginResult(_ loginResult: Result<Authentication, LoginInteractorLoginError>)
}

class LoginInteractor: LoginInteractorProtocol {
    
    weak var delegate: LoginInteractorDelegate?
    
    func login(delegate: LoginInteractorDelegate) {
        self.delegate = delegate
        guard let loginURL = VimeoNet.access.loginURL(delegate: self) else { return }
        AppProvider.appEventsHandler.openURL(loginURL, options: [:], completionHandler: nil)
    }
	
}

extension LoginInteractor: AccessLoginDelegate {
    
    func loginResult(_ loginResult: Result<AuthenticationNet, LoginError>) {
        switch loginResult {
        case .success(let authenticationNet):
            do {
                let authentication: Authentication = try Authentication(authenticationNet: authenticationNet)
                delegate?.loginResult(Result.success(authentication))
            } catch {
                delegate?.loginResult(Result.failure(.responseProblems))
            }
        case .failure(let loginError):
            switch loginError {
            case .noConnection:
                delegate?.loginResult(Result.failure(.noConnection))
            case .responseProblems:
                delegate?.loginResult(Result.failure(.responseProblems))
            }
        }
    }
    
}
