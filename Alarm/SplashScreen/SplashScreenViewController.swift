import UIKit

protocol SplashScreenDisplayLogic: class {
  
}

class SplashScreenViewController: UIViewController, SplashScreenDisplayLogic {
  var interactor: SplashScreenBusinessLogic?
  var router: (NSObjectProtocol & SplashScreenRoutingLogic & SplashScreenDataPassing)?

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  private func setup() {
    let viewController = self
    let interactor = SplashScreenInteractor()
    let presenter = SplashScreenPresenter()
    let router = SplashScreenRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  
}
