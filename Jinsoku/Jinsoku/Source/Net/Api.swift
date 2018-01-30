import Foundation

struct Api {
    
    let example: String

    init(baseUrl: String) {
        self.example = "\(baseUrl)\(Endpoint.example)"
    }
}
