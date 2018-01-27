import UIKit

enum Route {
    
    struct Keys {
        static let legalInfo = "legalInfo"
        static let mainAccountMovements = "mainAccountMovements"
    }
    case legalInfo
    case accountMovements(String)
    
    init?(shortcutItem: UIApplicationShortcutItem) {
        switch shortcutItem.type {
        case Keys.legalInfo: self = .legalInfo
        case Keys.mainAccountMovements: self = .accountMovements("0")
        default: return nil
        }
    }
}
