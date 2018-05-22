protocol SearchPresenterProtocol {
	var view: SearchViewControllerProtocol? { get set }
    init(_ view: SearchViewControllerProtocol?, interactor: SearchInteractorProtocol?, coordinator: HomeCoordinatorProtocol?)
    func viewLoaded()
}
