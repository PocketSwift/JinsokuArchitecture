import Foundation

class SplashPresenter: SplashPresenterProtocol {
	
	weak var view: SplashViewControllerProtocol?
	var coordinator: SplashCoordinatorProtocol?
	var interactor: SplashInteractorProtocol?
    
    required init(_ view: SplashViewControllerProtocol?, interactor: SplashInteractorProtocol?, coordinator: SplashCoordinatorProtocol?) {
        self.view = view
        self.interactor = interactor
        self.coordinator = coordinator
    }
    
    func viewLoaded() {
        
    }
    
    func goToTheNextController() {
        coordinator?.finishedScreen(.splash)
    }

}
