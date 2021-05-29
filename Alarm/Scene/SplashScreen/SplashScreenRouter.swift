import UIKit

@objc protocol SplashScreenRoutingLogic {
    func routeToMainTab()
}

protocol SplashScreenDataPassing {
    var dataStore: SplashScreenDataStore? { get }
}

class SplashScreenRouter: NSObject, SplashScreenRoutingLogic, SplashScreenDataPassing {
    weak var viewController: SplashScreenViewController?
    var dataStore: SplashScreenDataStore?
    
    func routeToMainTab() {
        let mainTab = MainTabBarController()
        viewController?.navigationController?.pushViewController(mainTab, animated: true)
    }
}
