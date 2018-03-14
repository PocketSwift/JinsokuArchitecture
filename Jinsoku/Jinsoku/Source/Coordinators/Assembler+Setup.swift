import Foundation
import Swinject

extension Assembler {
    static func setup() -> Resolver {
		return Assembler([
            SplashInjection(),
            LoginInjection()
            ], container: Container()).resolver
    }
}
