import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationTracking = PublishRelay<CLLocation>()
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func requestLocationAuthorization() {
        guard locationManager.authorizationStatus == .notDetermined else {
            checkLocationStatus()
            return
        }
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationTracking.accept(lastLocation)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationStatus()
    }
    
    private func checkLocationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            break
        default: break
        }
    }
}
