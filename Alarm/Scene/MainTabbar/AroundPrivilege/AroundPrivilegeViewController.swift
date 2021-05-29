import UIKit
import GoogleMaps

protocol AroundPrivilegeDisplayLogic: class {
}

class AroundPrivilegeViewController: UIViewController, AroundPrivilegeDisplayLogic {
    var interactor: AroundPrivilegeBusinessLogic?
    var router: (NSObjectProtocol & AroundPrivilegeRoutingLogic & AroundPrivilegeDataPassing)?
    
    static func initFromStoryboard() -> AroundPrivilegeViewController {
        let viewController = UIStoryboard(
            name: "AroundPrivilege",
            bundle: nil)
            .instantiateInitialViewController() as! AroundPrivilegeViewController
        return viewController
    }
    
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
        let interactor = AroundPrivilegeInteractor()
        let presenter = AroundPrivilegePresenter()
        let router = AroundPrivilegeRouter()
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
        setupGoogleMap()
    }
    
    func setupGoogleMap() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
}
