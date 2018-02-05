import Foundation
import ObjectMapper
import PocketNet

struct AuthenticationNet: Mappable, Convertible {
    
    struct Keys {
        static let token = "token"
    }
    
    let token: String
    
    init?(map: Map) {
        do {
            token = try map.value(Keys.token)
        } catch { return nil }
    }
    
    func mapping(map: Map) {
        token >>> map[Keys.token]
    }
    
    static func instance<T: Convertible>(_ JSONString: String) -> T? {
        return AuthenticationNet(JSONString: JSONString) as? T
    }
    
    func getJSONString() -> String? {
        return toJSONString()
    }
    
}
