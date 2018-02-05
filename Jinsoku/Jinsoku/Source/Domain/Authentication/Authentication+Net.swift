import Foundation

extension Authentication {
    
    init?(authenticationNet: AuthenticationNet) {
        guard let authentication = Authentication.Builder()
            .setToken(authenticationNet.token)
            .build()
            else { return nil }
        self = authentication
    }
    
}
