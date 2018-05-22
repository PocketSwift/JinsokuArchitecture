import Foundation
import Swinject

extension Assembler {
    static func setup() -> Resolver {
		return Assembler([
            SplashInjection(),
            LoginInjection(),
			MyVideoInjection(),
			SearchInjection()
            ], container: Container()).resolver
    }
}
