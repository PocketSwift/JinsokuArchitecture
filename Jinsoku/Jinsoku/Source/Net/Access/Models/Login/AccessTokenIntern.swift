import Foundation

extension AccessTokenIntern {
    enum InitError: Error {
        case noFile
        case invalidPlist
        case invalidSerialization(Error)
        case invalidTransformToDic
        case invalidDic
    }
}

struct AccessTokenIntern: BaseEncodable {
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case code
        case redirectUri = "redirect_uri"
        case clientIdentifier = "client_identifier"
        case clientSecret = "client_secret"
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
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(grantType, forKey: .grantType)
        try container.encode(code, forKey: .code)
        try container.encode(redirectUri, forKey: .redirectUri)
        try container.encode(clientIdentifier, forKey: .clientIdentifier)
        try container.encode(clientSecret, forKey: .clientSecret)
    }
    
}
