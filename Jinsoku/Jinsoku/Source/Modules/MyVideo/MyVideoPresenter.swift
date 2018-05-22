import Foundation

class MyVideoPresenter: MyVideoPresenterProtocol {
	
	weak var view: MyVideoViewControllerProtocol?
	var coordinator: HomeCoordinatorProtocol?
	var interactor: MyVideoInteractorProtocol?
    
    required init(_ view: MyVideoViewControllerProtocol?, interactor: MyVideoInteractorProtocol?, coordinator: HomeCoordinatorProtocol?) {
        self.view = view
        self.interactor = interactor
        self.coordinator = coordinator
    }
    
    func viewLoaded() {

    }
}
