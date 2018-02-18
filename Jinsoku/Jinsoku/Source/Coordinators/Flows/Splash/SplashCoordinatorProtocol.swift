enum SplashCoordinatorFinishedScreens {
    case splash(Bool)
}

protocol SplashCoordinatorProtocol: class {
    func finishedScreen(_ screen: SplashCoordinatorFinishedScreens)
}
