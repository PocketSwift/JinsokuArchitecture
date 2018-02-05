import Foundation

extension Authentication {
    
    init?(authenticationNet: AuthenticationNet) {
        guard let authentication = Authentication.Builder()
            .setToken(authenticationNet.accessToken)
            .build()
            else { return nil }
        self = authentication
    }
    
}
