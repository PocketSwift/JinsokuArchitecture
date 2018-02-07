import Foundation
import Result
import Kommander

protocol AccessEngineProtocol {
    func loginURL(delegate: AccessLoginDelegate) -> URL?
    func continueLoginOAuth(with state: String, and code: String)
}
