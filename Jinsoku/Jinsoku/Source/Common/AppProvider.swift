import Foundation
import Swinject

class AppProvider {
    
    static var appEventsHandler: AppEventsHandlerProtocol = AppEventsHandler()
        
    static var resolver: Resolver = Assembler.setup()
    
}
