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
	private var tabbarView: TabbarView? {
		return self.navigationManager.tabBarController
	}
	
	override func start(with route: Route?) {
		start()
	}
	
	override func start() {
//	tabbarView?.onViewDidLoad = runItemFlow()
//	tabbarView?.onItemFlowSelect = runItemFlow()
//	tabbarView?.onSettingsFlowSelect = runSettingsFlow()
		switch machine.state {
		case .load:
			load()
		case .show(let option):
			show(option)
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
    
	func show(_ option: HomeCoordinatorFinishedScreens.TabOption) {
//		self.navigationManager.setRootViewController(self.tabbarView)
	}
	
	func load() {
		self.navigationManager.setRootViewController(self.tabbarView)
	}
    
}
