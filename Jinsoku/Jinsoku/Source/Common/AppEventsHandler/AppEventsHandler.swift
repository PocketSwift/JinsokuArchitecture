import UIKit
import IQKeyboardManagerSwift

class AppEventsHandler: AppEventsHandlerProtocol {
    
    var application: UIApplication { return UIApplication.shared }
	var rootCoordinator: Coordinator?
    
    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool {
		
		// Setup keyboard manager
		IQKeyboardManager.sharedManager().enable = true
		
		// Setup root coordinator
		let navigationManager = NavigationManager()
		window?.rootViewController = navigationManager.currentNavController
		rootCoordinator = RootCoordinator(navigationManager: navigationManager)
		rootCoordinator?.start()
		window?.makeKeyAndVisible()

        return true
    }
    
    func willResignActive() {
    }
    
    func didEnterBackground() {
    }
    
    func willEnterForeground() {
    }
    
    func didBecomeActive() {
    }
    
    func willTerminate() {
    }
    
    func beginIgnoringInteractionEvents() {
        application.beginIgnoringInteractionEvents()
    }
    
    func endIgnoringInteractionEvents() {
        application.endIgnoringInteractionEvents()
    }
    
    func openURL(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?) {
        application.open(url, options: options, completionHandler: completionHandler)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool {
        if url.absoluteString.contains("vimeo150f5bb8a92fcdbfa8af1aec91484e596acdd524://auth"), let params = url.queryParameters, let state = params["state"], let code = params["code"] {
            VimeoNet.access.continueLoginOAuth(with: state, and: code)
        }
        return true
    }
    
}
