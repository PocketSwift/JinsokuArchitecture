import Foundation

enum AuthenticationError: Error {
    case badInit
}

extension Authentication {
    
    init(authenticationNet: AuthenticationNet) throws {
        guard let authentication = Authentication.Builder()
            .setToken(authenticationNet.accessToken)
            .build()
            else { throw AuthenticationError.badInit }
        self = authentication
    }
    
}
