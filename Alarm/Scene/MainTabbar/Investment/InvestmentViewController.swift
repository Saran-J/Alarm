import UIKit

protocol InvestmentDisplayLogic: class {
}

class InvestmentViewController: TabViewController, InvestmentDisplayLogic {
    var interactor: InvestmentBusinessLogic?
    var router: (NSObjectProtocol & InvestmentRoutingLogic & InvestmentDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    static func initFromStoryboard() -> InvestmentViewController {
        let viewController = UIStoryboard(
            name: "Investment",
            bundle: nil)
            .instantiateInitialViewController() as! InvestmentViewController
        return viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = InvestmentInteractor()
        let presenter = InvestmentPresenter()
        let router = InvestmentRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
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
