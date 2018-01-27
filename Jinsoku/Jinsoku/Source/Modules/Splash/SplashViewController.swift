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
		
    }
    
}

// MARK: SplashViewControllerProtocol
extension SplashViewController: SplashViewControllerProtocol {
}
