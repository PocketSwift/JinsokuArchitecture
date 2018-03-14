import Foundation
import PocketNet

struct AuthenticationNet: Convertible, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
    let accessToken: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decode(String.self, forKey: .accessToken)
    }

    static func instance<T: Convertible>(_ JSONString: String) -> T? {
        guard let data: Data = JSONString.data(using: String.Encoding.utf8) else { return nil }
        guard let authenticationNet: AuthenticationNet = try? JSONDecoder().decode(AuthenticationNet.self, from: data) else { return nil }
        return authenticationNet as? T
    }
    
}
