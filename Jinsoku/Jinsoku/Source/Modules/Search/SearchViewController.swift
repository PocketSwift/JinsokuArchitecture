import UIKit
import Reusable

class SearchViewController: UIViewController, StoryboardSceneBased {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol?
	static var sceneStoryboard = UIStoryboard(name: AppStoryboards.search.rawValue, bundle: nil)
	
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
    }

}

// MARK: SearchViewControllerProtocol
extension SearchViewController: SearchViewControllerProtocol {
	
}
