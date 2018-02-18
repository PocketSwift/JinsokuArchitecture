private class AuthFlowMachine {
	
	var authFinished = false
	
	enum AuthState {
		case initial
		case finished
	}
	
	var state: AuthState {
		switch authFinished {
		case false:
			return .initial
		case true:
			return .finished
		}
	}
}

class AuthCoordinator: BaseCoordinator, AuthCoordinatorProtocol {
	
	private var machine = AuthFlowMachine()
	
	override func start(with route: Route?) {
		start()
	}
	
	override func start() {
		switch machine.state {
		case .initial:
			showLogin()
		case .finished:
			finishFlow?()
		}
	}
	
	func finishedScreen(_ screen: AuthCoordinatorFinishedScreens) {
		switch screen {
		case .login(.auth(let token)):
			print("Token: \(token)")
			machine.authFinished = true
		case .login(.error):
			machine.authFinished = false
		}
		start()
	}
	
}

// MARK: NavigationManager resolve
extension AuthCoordinator {
	func showLogin() {
		if let vc = navigationManager.resolver.resolve(LoginViewControllerProtocol.self, argument: self as AuthCoordinatorProtocol?) {
			navigationManager.setRootViewController(vc)
			navigationManager.currentNavController?.setNavigationBarHidden(true, animated: false)
		}
	}
}
