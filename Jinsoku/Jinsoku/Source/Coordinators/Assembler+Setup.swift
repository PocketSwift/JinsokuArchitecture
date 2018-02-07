import Foundation
import Swinject
import SwinjectStoryboard

extension Assembler {
    static func setup() -> Assembler {
		return Assembler([SplashInjection(),
						  LoginInjection()],
						 container: SwinjectStoryboard.defaultContainer)
    }
}
