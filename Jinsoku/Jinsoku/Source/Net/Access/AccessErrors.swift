import Foundation

enum LoginError: Error {
    case responseProblems
    case noConnection
    case noVimeoAuthenticationPlist(Error)
    case badURLCreation
}
