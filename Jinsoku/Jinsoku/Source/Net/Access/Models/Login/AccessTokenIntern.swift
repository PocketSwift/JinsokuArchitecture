import Foundation
import ObjectMapper

extension AccessTokenIntern {
    enum InitError: Error {
        case noFile
        case invalidPlist
        case invalidSerialization(Error)
        case invalidTransformToDic
        case invalidDic
    }
}

struct AccessTokenIntern: Mappable {
    
    struct Keys {
        static let grantType = "grant_type"
        static let code = "code"
        static let redirectUri = "redirect_uri"
        static let clientIdentifier = "client_identifier"
        static let clientSecret = "client_secret"
    }
    
    let grantType: String = "authorization_code"
    let code: String
    let redirectUri: String
    let clientIdentifier: String
    let clientSecret: String
    
    private var base64: String { return ((clientIdentifier + ":" + clientSecret).base64Encoded()) ?? "" }
    
    var authHeader: [String: String] { return ["Authorization": "Basic \(base64)"] }
    
    init(code: String = "", redirectUri: String) throws {
        guard let plistPath = Bundle.main.path(forResource: KNet.Auth.vimeoFileName, ofType: KNet.Auth.vimeoFileType) else { throw InitError.noFile }
        guard let plistData = FileManager.default.contents(atPath: plistPath) else { throw InitError.invalidPlist }
        var format = PropertyListSerialization.PropertyListFormat.xml
        guard let plistDict: [String: AnyObject] = (try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) ~> InitError.invalidSerialization) as? [String: AnyObject]
        else { throw InitError.invalidTransformToDic }
        guard let clientIdentifier: String = plistDict["clientIdentifier"] as? String, let clientSecret: String = plistDict["clientSecret"] as? String else { throw InitError.invalidDic}
            
        self.clientIdentifier = clientIdentifier
        self.clientSecret = clientSecret
        self.code = code
        self.redirectUri = redirectUri.replacingOccurrences(of: "{clientIdentifier}", with: clientIdentifier)
    }
    
    init?(map: Map) {
        do {
            code = try map.value(Keys.code)
            redirectUri = try map.value(Keys.redirectUri)
            clientIdentifier = try map.value(Keys.clientIdentifier)
            clientSecret = try map.value(Keys.clientSecret)
        } catch { return nil }
    }
    
    func mapping(map: Map) {
        grantType >>> map[Keys.grantType]
        code >>> map[Keys.code]
        redirectUri >>> map[Keys.redirectUri]
    }
}
