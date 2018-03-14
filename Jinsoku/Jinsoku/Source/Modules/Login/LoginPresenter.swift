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
        interactor?.login(delegate: self)
    }
}

extension LoginPresenter: LoginInteractorDelegate {
    
    func loginResult(_ loginResult: Result<Authentication, LoginInteractorLoginError>) {
        switch loginResult {
        case .success(let authentication):
            self.coordinator?.finishedScreen(.login(.auth(authentication.token)))
        case .failure(let loginError):
            switch loginError {
            case .noConnection:
                break
            case .responseProblems:
                break
            }
        }
        
    }
    
}
