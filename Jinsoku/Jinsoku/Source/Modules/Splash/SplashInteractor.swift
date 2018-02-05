import Foundation
import KeychainAccess

class SplashInteractor: SplashInteractorProtocol {
    
    func isUserAuthenticated() -> Bool {
        let keychain = Keychain(service: K.Auth.keychainKey).synchronizable(true)
        guard let archivedToken = keychain[data: K.Auth.tokenKey] else { return false }
        return NSKeyedUnarchiver.unarchiveObject(with: archivedToken) as? String != nil ? true : false
    }
    
}
