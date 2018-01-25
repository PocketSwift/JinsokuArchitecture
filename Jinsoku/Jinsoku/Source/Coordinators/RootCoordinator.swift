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
    }
    
	func showLogin() {
        print("Show Login Controller")
    }
    
    func showOnboarding() {
        print("Show Onboarding Controller")
    }
    
    func showHome() {
        print("Show Home Controller")
    }
}
