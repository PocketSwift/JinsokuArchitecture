import UIKit
import Reusable

class LoginViewController: UIViewController, StoryboardSceneBased {

    var presenter: LoginPresenterProtocol?
    
    static var sceneStoryboard = UIStoryboard(name: AppStoryboards.login.rawValue, bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        presenter?.loginButtonTapped()
    }
    
}

// MARK: LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
}
