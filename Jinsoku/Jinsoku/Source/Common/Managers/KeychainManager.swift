import Foundation
import KeychainAccess

class KeychainManager {
    
    static func getStringWithKey(_ key: String) -> String? {
        let keychain = Keychain(service: K.Auth.keychainKey).synchronizable(true)
        guard let archivedToken = keychain[data: K.Auth.tokenKey] else { return nil }
        let unarchivedString = NSKeyedUnarchiver.unarchiveObject(with: archivedToken) as? String
        return unarchivedString
    }
    
}
