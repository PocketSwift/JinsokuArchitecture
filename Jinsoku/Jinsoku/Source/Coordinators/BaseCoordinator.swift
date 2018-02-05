import Foundation

protocol Coordinator: class {
    var navigationManager: NavigationManagerProtocol { get }
    var childCoordinators: [Coordinator] { get }
    var finishFlow: (() -> Void)? { get set }
    var route: Route? {get set}
	
    init(navigationManager: NavigationManagerProtocol)
    func add(childCoordinator coordinator: Coordinator)
    func remove(childCoordinator coordinator: Coordinator?)
    func start()
	func start(with route: Route?)
}

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    let navigationManager: NavigationManagerProtocol
    var finishFlow: (() -> Void)?
	var route: Route?
    
    required init(navigationManager: NavigationManagerProtocol) {
        self.navigationManager = navigationManager
    }
    
    func add(childCoordinator coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {return}
        childCoordinators.append(coordinator)
    }
    
    func remove(childCoordinator coordinator: Coordinator?) {
        childCoordinators = childCoordinators.filter {
            let aux = ($0 !== coordinator)
            print(aux ? "se queda \($0.self)": "se va \($0.self)")
            return aux
        }
        print(childCoordinators.description)
    }
    
    func start() {
        fatalError("Must Override")
    }
	
	func start(with route: Route?) {
		fatalError("Must Override")
	}

}
