import UIKit

public protocol AppEventsHandlerProtocol {
    func didFinishLaunching(launchOptions: [UIApplicationLaunchOptionsKey: Any]?, window: inout UIWindow?) -> Bool
    func willResignActive()
    func didEnterBackground()
    func willEnterForeground()
    func didBecomeActive()
    func willTerminate()
    func beginIgnoringInteractionEvents()
    func endIgnoringInteractionEvents()
    func openURL(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any]) -> Bool
}
