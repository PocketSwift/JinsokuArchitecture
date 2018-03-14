enum AuthCoordinatorFinishedScreens {
	enum LoginOption {
		case auth(String)
		case error
	}
    
	case login(LoginOption)
}

protocol AuthCoordinatorProtocol: class {
	func finishedScreen(_ screen: AuthCoordinatorFinishedScreens)
}
