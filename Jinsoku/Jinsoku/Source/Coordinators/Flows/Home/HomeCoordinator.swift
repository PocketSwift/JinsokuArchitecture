import UIKit

private class HomeFlowMachine {
	
	var homeFinished = false
	var currentTab: HomeCoordinatorFinishedScreens.TabOption = .search
	
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

extension HomeCoordinator {
    
	func show(_ option: HomeCoordinatorFinishedScreens.TabOption) {
		if let tabBarC = navigationManager.tabBarController {
			let vc1 = UIViewController()
			let nvc1 = UINavigationController(rootViewController: vc1)
			vc1.view.backgroundColor = .red
			let vc2 = UIViewController()
			let nvc2 = UINavigationController(rootViewController: vc2)
			vc2.view.backgroundColor = .blue
			tabBarC.viewControllers = [nvc1, nvc2]
			let tabTwoBarItem1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
			vc1.tabBarItem = tabTwoBarItem1
			let tabTwoBarItem2 = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
			vc2.tabBarItem = tabTwoBarItem2
			navigationManager.setRootViewController(tabBarC, hideBar: true)
			tabBarC.selectedIndex = option.rawValue
			if let nc = tabBarC.viewControllers?[option.rawValue] {				
				navigationManager.setCurrentNavigationController(nc)
			}
		}
	}
    
}
