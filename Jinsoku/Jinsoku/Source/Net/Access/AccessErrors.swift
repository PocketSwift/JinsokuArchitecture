import Foundation

public enum LoginError: Error {
    case responseProblems
    case noConnection
    case badCredentials
}
