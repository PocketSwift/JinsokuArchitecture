import Foundation

private class RootFlowMachine {
    
    var onboardingWasShown = true
	var isAutorized = false
    var isLoaded = false
    
    enum RootState {
        case splash
        case auth
        case onboarding
        case home
    }
    
    var state: RootState {
        
        switch (isLoaded, isAutorized, onboardingWasShown) {
        case (false, _, _):
            return .splash
        case (_, false, _):
            return .auth
        case (_, _, false):
            return .onboarding
        case (true, true, true):
            return .home
        }
    }
}

class RootCoordinator: BaseCoordinator {
    
    private var machine = RootFlowMachine()
	
	override func start(with route: Route?) {
		guard let currentRoute = route else {
			start()
			self.route = nil
			return
		}
		
		self.route = currentRoute
		
		childCoordinators.isEmpty ? start() : childCoordinators.forEach { $0.start(with: currentRoute) }
		self.route = nil
	}
	
    override func start() {
        switch machine.state {
        case .splash:
            showSplash()
        case .auth:
            showLogin()
        case .onboarding:
            showOnboarding()
        case .home:
            showHome()
        }
    }
}

extension RootCoordinator {
    
    func showSplash() {
		print("Show Splash Controller")
		let splashCoordinator = SplashCoordinator(navigationManager: navigationManager)
		splashCoordinator.finishFlow = { [weak self, weak splashCoordinator] in
			self?.machine.isLoaded = true
			self?.machine.isAutorized = splashCoordinator?.loginStatus ?? false
			let route = splashCoordinator?.route
			self?.remove(childCoordinator: splashCoordinator)
			self?.start(with: route)
		}
		self.add(childCoordinator: splashCoordinator)
		splashCoordinator.start(with: route)
    }
    
	func showLogin() {
		print("Show Login Controller")
		let authCoordinator = AuthCoordinator(navigationManager: navigationManager)
		authCoordinator.finishFlow = { [weak self, weak authCoordinator] in
			self?.machine.isAutorized = true
			let route = authCoordinator?.route
			self?.remove(childCoordinator: authCoordinator)
			self?.start(with: route)
		}
		self.add(childCoordinator: authCoordinator)
		authCoordinator.start(with: route)
		
	}
    
    func showOnboarding() {
        print("Show Onboarding Controller")
    }
    
    func showHome() {
        print("Show Home Controller")
		let homeCoordinator = HomeCoordinator(navigationManager: navigationManager)
		homeCoordinator.finishFlow = { [weak self, weak homeCoordinator] in
			let route = homeCoordinator?.route
			self?.remove(childCoordinator: homeCoordinator)
			self?.start(with: route)
		}
		self.add(childCoordinator: homeCoordinator)
		homeCoordinator.start(with: route)
    }
}
