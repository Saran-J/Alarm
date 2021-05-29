import UIKit

protocol SplashScreenBusinessLogic {
}

protocol SplashScreenDataStore {
}

class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore {
    var presenter: SplashScreenPresentationLogic?
    var worker: SplashScreenWorker?
}
