import Foundation

class LoginPresenter: LoginPresenterProtocol {
	
	weak var view: LoginViewControllerProtocol?
	var coordinator: AuthCoordinatorProtocol?
	var interactor: LoginInteractorProtocol?
    
    required init(_ view: LoginViewControllerProtocol?, interactor: LoginInteractorProtocol?, coordinator: AuthCoordinatorProtocol?) {
        self.view = view
        self.interactor = interactor
        self.coordinator = coordinator
    }
    
    func viewLoaded() {
        
    }
    
    // MARK: - Actions
    
    func loginButtonTapped() {
        interactor?.login()
        //self.coordinator?.finishedScreen(.login(.auth("tokentokentokentoken")))
    }
}
