import Foundation

class SplashInteractor: SplashInteractorProtocol {
	
	func isUserLogged() -> Bool {
        return KeychainManager.getStringWithKey(K.Auth.tokenKey) != nil ? true : false
	}
    
}
