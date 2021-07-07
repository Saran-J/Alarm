import Foundation
import RxSwift
import RxCocoa

enum NearByPrivilegeModel {
    struct Output {
        let privilegeResult: Driver<[NearByPrivilegeResponse]>
        let onError: Driver<ServiceError>
        let collectionHeader: [PrivilegeType] = [.all, .parking, .lounge, .fitness, .spa]
    }
    
    enum Constant {
        static let distanceToRefresh = 1000.0
    }
}
