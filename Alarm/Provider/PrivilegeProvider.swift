import Foundation
import Moya

enum PrivilegeProvider {
    case getPrivilege(category: String, lat: Double, lon: Double)
}

extension PrivilegeProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://asia-east2-krungthai-alarm.cloudfunctions.net/app") ?? URL(fileURLWithPath: "")
    }
    
    var path: String {
        switch self {
        case let .getPrivilege(category, lat, lon):
            let endPoint = "/api/partner"
            if category.isEmpty {
                return "\(endPoint)/\(lat)/\(lon)"
            }
            return "\(endPoint)/\(category)/\(lat)/\(lon)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPrivilege:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getPrivilege:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data {
        return "".data(using: .utf8) ?? Data()
    }
}
