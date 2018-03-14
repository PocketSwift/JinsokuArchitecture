import Reusable
import Swinject

class SplashInjection: Assembly {
    func assemble(container: Container) {
        
        container.register(SplashInteractorProtocol.self) { _ in
            SplashInteractor()
        }
        
        container.register(SplashPresenterProtocol.self) { (_, view: SplashViewControllerProtocol, interactor: SplashInteractorProtocol?, coordinator: SplashCoordinatorProtocol?) in
            SplashPresenter(view, interactor: interactor, coordinator: coordinator)
        }
        
        container.register(SplashViewControllerProtocol.self) { (r, coordinator: SplashCoordinatorProtocol?) in
            let c: SplashViewControllerProtocol = SplashViewController.instantiate()
            let interactor = r.resolve(SplashInteractorProtocol.self)
            let presenter = r.resolve(SplashPresenterProtocol.self, arguments: c, interactor, coordinator)
            c.presenter = presenter
            return c
        }

    }
}
