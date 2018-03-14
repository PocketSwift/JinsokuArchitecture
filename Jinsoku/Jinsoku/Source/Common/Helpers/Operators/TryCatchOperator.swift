import Foundation

infix operator ~>

func ~> <T>(expression: @autoclosure () throws -> T, errorTransform: (Error) -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorTransform(error)
    }
}
