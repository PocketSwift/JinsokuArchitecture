import UIKit

private class HomeFlowMachine {
	
	var load = false
	var homeFinished = false
	var currentTab: HomeCoordinatorFinishedScreens.TabOption = .search
	
	enum HomeState {
		case load
		case show(HomeCoordinatorFinishedScreens.TabOption)
		case finished
	}
	
	var state: HomeState {
		switch (load, homeFinished) {
		case (false, _):
			return .load
		case (_, false):
			return .show(currentTab)
		case (_, true):
			return .finished
		}
	}
}

class HomeCoordinator: BaseCoordinator, HomeCoordinatorProtocol {
	
	private var machine = HomeFlowMachine()
	private var tabbarView: TabbarView?
	
	override func start(with route: Route?) {
		start()
	}
	
	override func start() {
		self.tabbarView = TabbarController(onItemFlowSelect: show(.myVideos), onSettingsFlowSelect: show(.search), onViewDidLoad: show(.myVideos))
		switch machine.state {
		case .load:
			load()
		case .show(let option):
			//show(option)(nil)
			print("load option:\(option.rawValue)")
		case .finished:
			finishFlow?()
		}
	}
	
	func finishedScreen(_ screen: HomeCoordinatorFinishedScreens) {
		switch screen {
		case .load:
			machine.load = true
			machine.homeFinished = false
			machine.currentTab = .myVideos
		case .logout:
			machine.load = true
			machine.homeFinished = true
		case .tab(let option):
			machine.load = true
			machine.homeFinished = false
			machine.currentTab = option
		}
		start()
	}
	
}

extension HomeCoordinator {
	
	func show(_ option: HomeCoordinatorFinishedScreens.TabOption) -> ((UINavigationController) -> Void) {
		return { navigationController in
			if navigationController.viewControllers.isEmpty == true {
				switch option {
				case .myVideos:
					if let vc = AppProvider.resolver.resolve(MyVideoViewControllerProtocol.self, argument: self as HomeCoordinatorProtocol?) as? UIViewController {
						navigationController.viewControllers = [vc]
					}
				case .search:
					if let vc = AppProvider.resolver.resolve(SearchViewControllerProtocol.self, argument: self as HomeCoordinatorProtocol?) as? UIViewController {
						navigationController.viewControllers = [vc]
					}
				default:
					let vc = UIViewController()
					vc.view.backgroundColor = .green
					navigationController.viewControllers = [vc]
				}
			}
		}
	}
	
	func load() {
		self.navigationManager.setRootViewController(self.tabbarView)
	}
}
