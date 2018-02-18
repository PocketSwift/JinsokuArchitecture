import Foundation

enum LoginError: Error {
    case responseProblems
    case noConnection
    case noVimeoAuthenticationPlist(Error?)
    case badURLCreation
}

extension LoginError: Equatable {
}

func == (lhs: LoginError, rhs: LoginError) -> Bool {
    switch (lhs, rhs) {
    case (.noVimeoAuthenticationPlist, .noVimeoAuthenticationPlist):
        return true
    case ( .responseProblems, .responseProblems):
        return true
    case ( .noConnection, .noConnection):
        return true
    case ( .badURLCreation, .badURLCreation):
        return true
    default:
        return false
    }
}

extension Error {
    var isLoginError: Bool {
        guard let err = self as? LoginError else { return false }
        return err == LoginError.responseProblems || err == LoginError.badURLCreation || err == LoginError.responseProblems || err == LoginError.noVimeoAuthenticationPlist(nil)
    }
}
