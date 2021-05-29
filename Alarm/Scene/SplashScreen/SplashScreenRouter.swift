import UIKit

@objc protocol SplashScreenRoutingLogic {
}

protocol SplashScreenDataPassing {
    var dataStore: SplashScreenDataStore? { get }
}

class SplashScreenRouter: NSObject, SplashScreenRoutingLogic, SplashScreenDataPassing {
    weak var viewController: SplashScreenViewController?
    var dataStore: SplashScreenDataStore?
}
