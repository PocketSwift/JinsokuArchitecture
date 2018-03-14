import Foundation

protocol BaseEncodable: Encodable { }

extension BaseEncodable {
    func getJSONString() -> String? {
        guard let encodedData = try? JSONEncoder().encode(self), let jsonString = String(data: encodedData, encoding: .utf8) else { return nil }
        return jsonString
    }
}
