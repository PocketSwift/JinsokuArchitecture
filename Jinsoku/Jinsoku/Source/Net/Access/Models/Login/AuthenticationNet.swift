import Foundation
import ObjectMapper
import PocketNet

struct AuthenticationNet: Mappable, Convertible {
    
    struct Keys {
        static let accessToken = "access_token"
    }
    
    let accessToken: String
    
    init?(map: Map) {
        do {
            accessToken = try map.value(Keys.accessToken)
        } catch { return nil }
    }
    
    func mapping(map: Map) {
        accessToken >>> map[Keys.accessToken]
    }
    
    static func instance<T: Convertible>(_ JSONString: String) -> T? {
        return AuthenticationNet(JSONString: JSONString) as? T
    }
    
    func getJSONString() -> String? {
        return toJSONString()
    }
    
}
