import Foundation
import ObjectMapper

struct AccessTokenIntern: Mappable {
    
    struct Keys {
        static let grantType = "grant_type"
        static let code = "code"
        static let redirectUri = "redirect_uri"
    }
    
    let grantType: String = "authorization_code"
    let code: String
    let redirectUri: String
    
    static private let base64 = "150f5bb8a92fcdbfa8af1aec91484e596acdd524:Ddetogf7HApPnL6ZV9OXqL70V33+TWYLb0zwKjqxrouVRAERHpxgG3Gsk1lFJtkP0e/qLS9W7dhNlmfSYI1Ml/EIpSd+HkNDnmTwF0QjQRT5Gtl7L1HsceZuq6G+Ens9".base64Encoded() ?? ""
    
    let authHeader: [String: String] = ["Authorization": "Basic \(AccessTokenIntern.base64)"]
    
    init(code: String, redirectUri: String) {
        self.code = code
        self.redirectUri = redirectUri
    }
    
    init?(map: Map) {
        do {
            code = try map.value(Keys.code)
            redirectUri = try map.value(Keys.redirectUri)
        } catch { return nil }
    }
    
    func mapping(map: Map) {
        grantType >>> map[Keys.grantType]
        code >>> map[Keys.code]
        redirectUri >>> map[Keys.redirectUri]
    }
}
