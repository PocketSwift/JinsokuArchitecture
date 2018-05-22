import UIKit

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {
	
	var onItemFlowSelect: ((UINavigationController) -> Void)?
	var onSettingsFlowSelect: ((UINavigationController) -> Void)?
	var onViewDidLoad: ((UINavigationController) -> Void)?
	
	init(onItemFlowSelect: ((UINavigationController) -> Void)?, onSettingsFlowSelect: ((UINavigationController) -> Void)?, onViewDidLoad: ((UINavigationController) -> Void)?) {
		self.onViewDidLoad = onViewDidLoad
		self.onItemFlowSelect = onItemFlowSelect
		self.onSettingsFlowSelect = onSettingsFlowSelect
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		let nvc1 = UINavigationController()
		let tabTwoBarItem1 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
		nvc1.tabBarItem = tabTwoBarItem1
		let nvc2 = UINavigationController()
		let tabTwoBarItem2 = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
		nvc2.tabBarItem = tabTwoBarItem2
		self.viewControllers = [nvc1, nvc2]

		delegate = self
		if let controller = customizableViewControllers?.first as? UINavigationController {
			onViewDidLoad?(controller)
		}
	}
	
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
		guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
		
		if selectedIndex == 0 {
			onItemFlowSelect?(controller)
		} else if selectedIndex == 1 {
			onSettingsFlowSelect?(controller)
		}
	}
}
