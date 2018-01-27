protocol SplashPresenterProtocol {
    weak var view: SplashViewControllerProtocol? { get set }
    init(_ view: SplashViewControllerProtocol?, interactor: SplashInteractorProtocol?, coordinator: SplashCoordinatorProtocol?)
    func viewLoaded()
    func goToTheNextController()
}
