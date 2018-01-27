enum SplashCoordinatorFinishedScreens {
    case splash
}

protocol SplashCoordinatorProtocol: class {
    func finishedScreen(_ screen: SplashCoordinatorFinishedScreens)
}
