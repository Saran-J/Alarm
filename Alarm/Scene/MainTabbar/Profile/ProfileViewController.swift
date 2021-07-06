import UIKit

protocol ProfileDisplayLogic: class {
}

class ProfileViewController: TabViewController, ProfileDisplayLogic {
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic & ProfileDataPassing)?
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var amountlabel: UILabel!
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    static func initFromStoryboard() -> ProfileViewController {
        let viewController = UIStoryboard(
            name: "Profile",
            bundle: nil)
            .instantiateInitialViewController() as! ProfileViewController
        return viewController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
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
        setupProfileImage()
        displayAmountLabel(
            amount: "10,000,000",
            totalAmount: "50,000,000"
        )
    }
    
    func setupProfileImage() {
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
    }
    
    func displayAmountLabel(amount: String, totalAmount: String) {
        let amountString = NSAttributedString(
            string: amount,
            attributes: [
                NSAttributedString.Key.font: UIFont.ktbFont(
                    size: 20,
                    style: .bold
                ),
                NSAttributedString.Key.foregroundColor: UIColor.colorWithRGBA(
                    0,
                    166,
                    230
                )
            ])
        let totalAmountString = NSAttributedString(
            string: "/ \(totalAmount)",
            attributes: [
                NSAttributedString.Key.font: UIFont.ktbFont(
                    size: 20,
                    style: .regular
                ),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        let result = NSMutableAttributedString()
        result.append(amountString)
        result.append(totalAmountString)
        amountlabel.attributedText = result
    }
}
