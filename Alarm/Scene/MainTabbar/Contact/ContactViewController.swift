import UIKit

protocol ContactDisplayLogic: class {
}

class ContactViewController: TabViewController, ContactDisplayLogic {
    var interactor: ContactBusinessLogic?
    var router: (NSObjectProtocol & ContactRoutingLogic & ContactDataPassing)?
    
    @IBOutlet weak var contactCollectionView: UICollectionView!
    
    let contactData: [ContactModel] = [
        ContactModel(
            name: "อรวรรณ",
            nickname: "ปุ้ย",
            latestContactDate: "12 มิ.ย. 64",
            imageUrl: "mockContact1"),
        
        ContactModel(
            name: "สุพรรณณา",
            nickname: "เล็ก",
            latestContactDate: "11 มิ.ย. 64",
            imageUrl: "mockContact2")
    ]
    
    func setupCollectionView() {
        contactCollectionView.register(
            UINib(
                nibName: "ContactCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "contactCell")
        
        contactCollectionView.register(
            UINib(
                nibName: "BlankCell",
                bundle: nil
            ),
            forCellWithReuseIdentifier: "blankCell")
    }
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    static func initFromStoryboard() -> ContactViewController {
        let viewController = UIStoryboard(
            name: "Contact",
            bundle: nil)
            .instantiateInitialViewController() as! ContactViewController
        return viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ContactInteractor()
        let presenter = ContactPresenter()
        let router = ContactRouter()
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
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension ContactViewController: UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactData.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 || indexPath.row == contactData.count + 1 {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "blankCell",
                for: indexPath
            )
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "contactCell",
            for: indexPath
        ) as? ContactCell else {
            return UICollectionViewCell()
        }
        let data = contactData[indexPath.row - 1]
        cell.setupCellData(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == contactData.count + 1 {
            return CGSize(width: 8, height: 125)
        }
        return CGSize(width: 232, height: 125)
    }
}
