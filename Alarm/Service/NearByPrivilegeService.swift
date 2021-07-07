import Foundation
import RxSwift

struct NearByPrivilegeResponse: Codable {
    var docId: String
    var id: String
    var name: String
    var category: String
    var latitude: Double
    var longitude: Double
    var description: String
    var tel: String
    var distance: Double
}

class NearByPrivilegeService: BaseService<PrivilegeProvider, [NearByPrivilegeResponse]> {
    func executeService(category: PrivilegeType, lat: Double, lon: Double) -> Observable<[NearByPrivilegeResponse]> {
        return super.callService(
            target: PrivilegeProvider.getPrivilege(
                category: category.rawValue,
                lat: lat,
                lon: lon
            )
        )
    }
}
