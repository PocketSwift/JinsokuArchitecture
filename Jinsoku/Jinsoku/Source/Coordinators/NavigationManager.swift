import UIKit

class NavigationManager: NSObject, NavigationManagerProtocol {
	
    private var completions: [UIViewController : () -> Void] = [:]

    var currentNavController: UINavigationController?
    var navigationControllers: [UINavigationController]
	
    override init() {
        navigationControllers = [UINavigationController]()
        super.init()
        self.configure()
    }
    
    func configure() {
        let navigationController = UINavigationController()
        setCurrentNavigationController(navigationController)
        currentNavController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setCurrentNavigationController(_ navigationController: Any?) {
        guard let nc = navigationController as? UINavigationController else { return }
        currentNavController = nc
        currentNavController?.delegate = self
        if !navigationControllers.contains(nc) {
            navigationControllers.append(nc)
        }
    }
    
    func presentVC(_ viewController: Any?, animated: Bool, completion: (() -> Void)?) {
        if let vc = viewController as? UIViewController {
            self.currentNavController?.present(vc, animated: animated, completion: completion)
        }
    }
    
    func dismissVC(animated: Bool, completion: (() -> Void)?) {
        self.currentNavController?.dismiss(animated: animated, completion: completion)
    }
    
    func pushVC(_ viewController: Any?, animated: Bool, backCompletion: (() -> Void)? = nil) {
        if let vc = viewController as? UIViewController {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            currentNavController?.viewControllers.last?.navigationItem.backBarButtonItem = backItem
            if let completion = backCompletion {
                completions[vc] = completion
            }
            self.currentNavController?.pushViewController(vc, animated: animated)
        }
    }
    
    func popVC(animated: Bool) {
        if let controller = self.currentNavController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func popToRoot(animated: Bool) {
        if let controllers = self.currentNavController?.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    func setRootViewController(_ controller: Any?) {
        setRootViewController(controller, hideBar: false)
    }
    
    func setRootViewController(_ controller: Any?, hideBar: Bool) {
        completions = [:]
        if let vc = controller as? UIViewController {
            currentNavController?.setViewControllers([vc], animated: false)
            currentNavController?.isNavigationBarHidden = hideBar
        }
    }
    
}

extension NavigationManager: UINavigationControllerDelegate {
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Ensure the view controller is popping
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController) else {
                return
        }
        runCompletion(for: poppedViewController)
    }
    
}
