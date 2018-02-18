private class HomeFlowMachine {
	
	var homeFinished = false
	var currentTab: HomeCoordinatorFinishedScreens.TabOption = .myVideos
	
	enum HomeState {
		case show(HomeCoordinatorFinishedScreens.TabOption)
		case finished
	}
	
	var state: HomeState {
		switch homeFinished {
		case false:
			return .show(currentTab)
		case true:
			return .finished
		}
	}
}

class HomeCoordinator: BaseCoordinator, HomeCoordinatorProtocol {
	
	private var machine = HomeFlowMachine()
	
	override func start(with route: Route?) {
		start()
	}
	
	override func start() {
		switch machine.state {
		case .show(let option):
			show(option)
		case .finished:
			finishFlow?()
		}
	}
	
	func finishedScreen(_ screen: HomeCoordinatorFinishedScreens) {
		switch screen {
		case .logout:
			machine.homeFinished = true
		case .tab(let option):
			machine.homeFinished = false
			machine.currentTab = option
		}
		start()
	}
	
}

// MARK: NavigationManager resolve
extension HomeCoordinator {
	func show(_ option: HomeCoordinatorFinishedScreens.TabOption) {
		if let vc = navigationManager.resolver.resolve(LoginViewControllerProtocol.self, argument: self as HomeCoordinatorProtocol?) {
			navigationManager.setRootViewController(vc)
			navigationManager.currentNavController?.setNavigationBarHidden(true, animated: false)
		}
	}
}
