import Foundation

class SearchPresenter: SearchPresenterProtocol {
	
	weak var view: SearchViewControllerProtocol?
	var coordinator: HomeCoordinatorProtocol?
	var interactor: SearchInteractorProtocol?
    
    required init(_ view: SearchViewControllerProtocol?, interactor: SearchInteractorProtocol?, coordinator: HomeCoordinatorProtocol?) {
        self.view = view
        self.interactor = interactor
        self.coordinator = coordinator
    }
    
    func viewLoaded() {

    }
}
