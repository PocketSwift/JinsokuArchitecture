import UIKit
import Reusable
import SnapKit

class SplashViewController: UIViewController, StoryboardSceneBased {

    var presenter: SplashPresenterProtocol?
    
    static var sceneStoryboard = UIStoryboard(name: AppStoryboards.splash.rawValue, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
		delay(3) {
			self.presenter?.delayCompleted()
		}
    }
		
	fileprivate func delay(_ delay: Double, closure: @escaping () -> Void) {
		DispatchQueue.main.asyncAfter(
			deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
		)
	}
	
}

// MARK: SplashViewControllerProtocol
extension SplashViewController: SplashViewControllerProtocol {
}
