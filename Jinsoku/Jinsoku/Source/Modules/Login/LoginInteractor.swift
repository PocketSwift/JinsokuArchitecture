import UIKit

class LoginInteractor: LoginInteractorProtocol {
    
    func login() {
        guard let loginURL = VimeoNet.access.loginURL() else { return }
        AppProvider.appEventsHandler.openURL(loginURL, options: [:], completionHandler: nil)
    }
	
}
