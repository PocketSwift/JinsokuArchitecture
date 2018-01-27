import Reusable
import Swinject
import SwinjectStoryboard

class LoginInjection: Assembly {
    func assemble(container: Container) {
        
        container.register(LoginInteractorProtocol.self) { _ in
            LoginInteractor()
        }
        
        container.register(LoginPresenterProtocol.self) { (_, view: LoginViewControllerProtocol, interactor: LoginInteractorProtocol?, coordinator: AuthCoordinatorProtocol?) in
            LoginPresenter(view, interactor: interactor, coordinator: coordinator)
        }
        
        container.register(LoginViewControllerProtocol.self) { (r, coordinator: AuthCoordinatorProtocol?) in
            let c: LoginViewControllerProtocol = LoginViewController.instantiate()
            let interactor = r.resolve(LoginInteractorProtocol.self)
            let presenter = r.resolve(LoginPresenterProtocol.self, arguments: c, interactor, coordinator)
            c.presenter = presenter
            return c
        }
        
        container.storyboardInitCompleted(LoginViewController.self) { _, _  in }
    }
}
