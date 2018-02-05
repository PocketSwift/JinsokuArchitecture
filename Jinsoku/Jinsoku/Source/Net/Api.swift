import Foundation

struct Api {
    
    let authorize: String
    let accessToken: String

    init(baseUrl: String) {
        self.authorize = "\(baseUrl)\(Endpoint.authorize)"
        self.accessToken = "\(baseUrl)\(Endpoint.accessToken)"
    }
}
