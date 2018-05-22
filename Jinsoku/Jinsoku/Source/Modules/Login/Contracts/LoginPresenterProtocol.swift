protocol LoginPresenterProtocol {
	var view: LoginViewControllerProtocol? { get set }
    init(_ view: LoginViewControllerProtocol?, interactor: LoginInteractorProtocol?, coordinator: AuthCoordinatorProtocol?)
    func viewLoaded()
    func loginButtonTapped()
}
