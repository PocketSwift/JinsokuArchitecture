import Reusable
import Swinject

class SearchInjection: Assembly {
    func assemble(container: Container) {
        
        container.register(SearchInteractorProtocol.self) { _ in
            SearchInteractor()
        }
        
        container.register(SearchPresenterProtocol.self) { (_, view: SearchViewControllerProtocol, interactor: SearchInteractorProtocol?, coordinator: HomeCoordinatorProtocol?) in
            SearchPresenter(view, interactor: interactor, coordinator: coordinator)
        }
        
        container.register(SearchViewControllerProtocol.self) { (r, coordinator: HomeCoordinatorProtocol?) in
            let c: SearchViewControllerProtocol = SearchViewController.instantiate()
            let interactor = r.resolve(SearchInteractorProtocol.self)
            let presenter = r.resolve(SearchPresenterProtocol.self, arguments: c, interactor, coordinator)
            c.presenter = presenter
            return c
        }
    }
}
