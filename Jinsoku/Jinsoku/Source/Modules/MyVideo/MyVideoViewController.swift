import UIKit
import Reusable

class MyVideoViewController: UIViewController, StoryboardSceneBased {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MyVideoPresenterProtocol?
	static var sceneStoryboard = UIStoryboard(name: AppStoryboards.myVideo.rawValue, bundle: nil)
	
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }

}

// MARK: MyVideoViewControllerProtocol
extension MyVideoViewController: MyVideoViewControllerProtocol {
	
}
