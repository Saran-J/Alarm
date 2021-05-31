import UIKit
import GoogleMaps
import RxSwift

protocol AroundPrivilegeDisplayLogic: class {
}

class AroundPrivilegeViewController: UIViewController, AroundPrivilegeDisplayLogic {
    var interactor: AroundPrivilegeBusinessLogic?
    var router: (NSObjectProtocol & AroundPrivilegeRoutingLogic & AroundPrivilegeDataPassing)?
    var locationManager = LocationManager()
    let zoomConst: Float = 6.0
    let disposeBag = DisposeBag()
    lazy var camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: zoomConst)
    lazy var mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
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
        bindingLocationManager()
        locationManager.requestLocationAuthorization()
    }
    
    func setupGoogleMap() {
        self.view.addSubview(mapView)
    }
    
    func bindingLocationManager() {
        locationManager.locationTracking
        .bind { [unowned self] location in
            self.mapView.animate(
                to: GMSCameraPosition(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude,
                    zoom: self.zoomConst ))
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = self.mapView
        }
        .disposed(by: disposeBag)
    }
}
