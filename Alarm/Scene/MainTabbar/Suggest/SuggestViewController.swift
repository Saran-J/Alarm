import UIKit

protocol SuggestDisplayLogic: class {
}

class SuggestViewController: TabViewController, SuggestDisplayLogic {
    var interactor: SuggestBusinessLogic?
    var router: (NSObjectProtocol & SuggestRoutingLogic & SuggestDataPassing)?
    
    @IBOutlet weak var privilegeCollectionView: UICollectionView!
    @IBOutlet weak var promotionCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    let privilegeDelegate = PrivilegeDelegate()
    let promotionDelegate = PromotionDelegate()
    let newsDelegate = NewsDelegate()
    
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    static func initFromStoryboard() -> SuggestViewController {
        let viewController = UIStoryboard(
            name: "Suggest",
            bundle: nil)
            .instantiateInitialViewController() as! SuggestViewController
        return viewController
    }
    
    func setupHeader() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.headerView.frame
        rectShape.position = self.headerView.center
        rectShape.path = UIBezierPath(
            roundedRect: self.headerView.bounds,
            byRoundingCorners: [.bottomLeft],
            cornerRadii: CGSize(width: 25, height: 25)
        ).cgPath
        self.headerView.layer.mask = rectShape
    }
    
    func setupPrivilegeCollectionView() {
        privilegeCollectionView.register(
            UINib(
                nibName: "PrivilegeCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "privilegeCell")
        privilegeCollectionView.register(
            UINib(
                nibName: "BlankCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "blankCell")
        privilegeCollectionView.dataSource = self.privilegeDelegate
        privilegeCollectionView.delegate = self.privilegeDelegate
    }
    
    func setupPromotionCollectionView() {
        promotionCollectionView.register(
            UINib(
                nibName: "PromotionCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "promotionCell")
        promotionCollectionView.register(
            UINib(
                nibName: "BlankCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "blankCell")
        promotionCollectionView.dataSource = self.promotionDelegate
        promotionCollectionView.delegate = self.promotionDelegate
    }
    
    func setupNewsCollectionView() {
        newsCollectionView.register(
            UINib(
                nibName: "NewsCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "newsCell")
        newsCollectionView.register(
            UINib(
                nibName: "BlankCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "blankCell")
        newsCollectionView.dataSource = self.newsDelegate
        newsCollectionView.delegate = self.newsDelegate
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = SuggestInteractor()
        let presenter = SuggestPresenter()
        let router = SuggestRouter()
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
        setupPrivilegeCollectionView()
        setupPromotionCollectionView()
        setupNewsCollectionView()
    }
    
    @IBAction func onClickPrivilege() {
        let aroundVC = AroundPrivilegeViewController.initFromStoryboard()
        onRoute.accept(aroundVC)
    }
}
