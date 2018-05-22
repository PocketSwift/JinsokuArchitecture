import Reusable
import Swinject

class MyVideoInjection: Assembly {
    func assemble(container: Container) {
        
        container.register(MyVideoInteractorProtocol.self) { _ in
            MyVideoInteractor()
        }
        
        container.register(MyVideoPresenterProtocol.self) { (_, view: MyVideoViewControllerProtocol, interactor: MyVideoInteractorProtocol?, coordinator: HomeCoordinatorProtocol?) in
            MyVideoPresenter(view, interactor: interactor, coordinator: coordinator)
        }
        
        container.register(MyVideoViewControllerProtocol.self) { (r, coordinator: HomeCoordinatorProtocol?) in
            let c: MyVideoViewControllerProtocol = MyVideoViewController.instantiate()
            let interactor = r.resolve(MyVideoInteractorProtocol.self)
            let presenter = r.resolve(MyVideoPresenterProtocol.self, arguments: c, interactor, coordinator)
            c.presenter = presenter
            return c
        }
    }
}
