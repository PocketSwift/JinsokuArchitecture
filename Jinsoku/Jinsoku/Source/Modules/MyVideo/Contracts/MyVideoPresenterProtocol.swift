protocol MyVideoPresenterProtocol {
    weak var view: MyVideoViewControllerProtocol? { get set }
    init(_ view: MyVideoViewControllerProtocol?, interactor: MyVideoInteractorProtocol?, coordinator: HomeCoordinatorProtocol?)
    func viewLoaded()
}
