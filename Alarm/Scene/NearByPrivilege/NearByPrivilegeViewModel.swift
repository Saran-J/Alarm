import Foundation
import CoreLocation
import RxSwift
import RxCocoa

protocol NearByPrivilegeViewModelProtocol {
    var output: NearByPrivilegeModel.Output { get }
    func getNearByPrivilege()
    func startLocation()
    func selectCategory(_ type: PrivilegeType)
}

class NearByPrivilegeViewModel: BaseViewModel, NearByPrivilegeViewModelProtocol {
    typealias Output = NearByPrivilegeModel.Output
    typealias Constant = NearByPrivilegeModel.Constant
    
    let categorySubject = BehaviorSubject<PrivilegeType>(value: .all)
    
    let output: Output
    let nearByPrivilegeSubject = PublishSubject<[NearByPrivilegeResponse]>()
    let nearByPrivilegeService = NearByPrivilegeService()
    let onErrorSubject = PublishSubject<ServiceError>()
    let oldPoint: CLLocation? = nil
    
    var locationManager = LocationManager()
    override init() {
        output = NearByPrivilegeModel.Output(
            privilegeResult: nearByPrivilegeSubject.asDriverIgnoreError(),
            onError: onErrorSubject.asDriverIgnoreError()
        )
        super.init()
    }
    
    func getNearByPrivilege() {
        let locationTrack = locationManager
            .locationTracking
            .distinctUntilChanged()
            .filter { newPoint in
                self.shouldRefreshList(
                oldPoint: self.oldPoint,
                newPoint: newPoint
                )
            }
        Observable.combineLatest(locationTrack, categorySubject) { location, category in
            return (location, category)
        }
        .flatMap { resp in
            self.nearByPrivilegeService.executeService(
                category: resp.1,
                lat: resp.0.coordinate.latitude,
                lon: resp.0.coordinate.longitude
            )
        }
        .subscribeService { [weak self] response in
            self?.nearByPrivilegeSubject.onNext(response)
        } onError: { [weak self] error in
            self?.onErrorSubject.onNext(error)
        }
        .disposed(by: disposeBag)
    }
    
    func startLocation() {
        locationManager.requestLocationAuthorization()
    }
    
    func selectCategory(_ type: PrivilegeType) {
        categorySubject.onNext(type)
    }
    
    private func shouldRefreshList(
        oldPoint: CLLocation?,
        newPoint: CLLocation
    ) -> Bool {
        guard let oldPoint = oldPoint else { return true }
        let distanceInMeters = oldPoint.distance(from: newPoint)
        return distanceInMeters < Constant.distanceToRefresh
    }
}
