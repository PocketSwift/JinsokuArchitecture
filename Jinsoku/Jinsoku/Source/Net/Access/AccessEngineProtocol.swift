import Foundation
import Result
import Kommander

protocol AccessEngineProtocol {
    func loginURL() -> URL?
    func continueLoginOAuth(with state: String, and code: String)
}
