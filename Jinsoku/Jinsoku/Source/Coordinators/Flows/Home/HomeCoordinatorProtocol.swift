enum HomeCoordinatorFinishedScreens {
	enum TabOption: Int {
		case myVideos
		case search
		case download
		case upload
		case saved
	}
	
	case logout
	case tab(TabOption)
}

protocol HomeCoordinatorProtocol: class {
	func finishedScreen(_ screen: HomeCoordinatorFinishedScreens)
}
