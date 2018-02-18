private class SplashFlowMachine {
    
    enum SplashState {
        case finished
        case initial
    }
    
    var splashFinished = false
    
    var state: SplashState {
        switch splashFinished {
        case false:
            return .initial
        case true:
            return .finished
        }
    }
    
}

class SplashCoordinator: BaseCoordinator, SplashCoordinatorProtocol {
    
    private var machine = SplashFlowMachine()
    var loginStatus = false
	
    override func start(with route: Route?) {
        if let route = route {
            switch route {
            case .legalInfo,
                 .accountMovements:
                self.route = route
            }
        }
        start()
    }
    
    override func start() {
        switch machine.state {
        case .initial:
            showSplash()
        case .finished:
            finishFlow?()
        }
    }
    
    func finishedScreen(_ screen: SplashCoordinatorFinishedScreens) {
        switch screen {
        case .splash(let loginStatus):
            machine.splashFinished = true
			self.loginStatus = loginStatus
        }
        start()
    }
    
}

// MARK: NavigationManager resolve
extension SplashCoordinator {
    func showSplash() {
        if let vc = navigationManager.resolver.resolve(SplashViewControllerProtocol.self, argument: self as SplashCoordinatorProtocol?) {
            navigationManager.setRootViewController(vc)
            navigationManager.currentNavController?.setNavigationBarHidden(true, animated: false)
        }
    }
}
