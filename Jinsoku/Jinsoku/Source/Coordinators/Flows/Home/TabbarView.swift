import UIKit

protocol TabbarView: class {
	var onItemFlowSelect: ((UINavigationController) -> Void)? { get set }
	var onSettingsFlowSelect: ((UINavigationController) -> Void)? { get set }
	var onViewDidLoad: ((UINavigationController) -> Void)? { get set }
}
