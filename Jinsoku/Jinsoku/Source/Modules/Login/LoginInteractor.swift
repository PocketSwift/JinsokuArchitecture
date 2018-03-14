import UIKit
import KeychainAccess

protocol LoginInteractorDelegate: class {
    func loginResult(_ loginResult: Result<Authentication, LoginInteractorLoginError>)
}

class LoginInteractor: LoginInteractorProtocol {
    
    weak var delegate: LoginInteractorDelegate?
    
    func login(delegate: LoginInteractorDelegate) {
        self.delegate = delegate
        do {
            let loginURL = try VimeoNet.access.loginURL(delegate: self)
            AppProvider.appEventsHandler.openURL(loginURL, options: [:], completionHandler: nil)
        } catch let error as LoginError {
            switch error {
            case .noVimeoAuthenticationPlist:
                print("Wrong or missing Authenthication Plist for vimeo")
            default:
                print("Unspecific Login error")
            }
        } catch {
            print("Unexpected Error")
        }
    }
    
    private func saveToken(_ token: String) {
        let keychain = Keychain(service: K.Auth.keychainKey)
        let archivedToken = NSKeyedArchiver.archivedData(withRootObject: token)
        keychain[data: K.Auth.tokenKey] = archivedToken
    }
	
}

extension LoginInteractor: AccessLoginDelegate {
    
    func loginResult(_ loginResult: Result<AuthenticationNet, LoginError>) {
        switch loginResult {
        case .success(let authenticationNet):
            do {
                let authentication: Authentication = try Authentication(authenticationNet: authenticationNet)
                saveToken(authentication.token)
                delegate?.loginResult(Result.success(authentication))
            } catch {
                delegate?.loginResult(Result.failure(.responseProblems))
            }
        case .failure(let loginError):
            switch loginError {
            case .noConnection:
                delegate?.loginResult(Result.failure(.noConnection))
            case .responseProblems, .badURLCreation, .noVimeoAuthenticationPlist:
                delegate?.loginResult(Result.failure(.responseProblems))

            }
        }
    }
    
}
