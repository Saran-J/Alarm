import Foundation
import UIKit

enum PrivilegeType: String, Decodable, Encodable {
    case all
    case parking
    case lounge
    case fitness
    case spa
    
    func getName() -> String {
        switch self {
        case .parking:
            return "พื้นที่จอดรถ"
        case .lounge:
            return "ห้องรับรองพิเศษ"
        case .fitness:
            return "ฟิตเนส"
        case .spa:
            return "สปา"
        case .all:
            return "ทั้งหมด"
        }
    }
    
    func getImage() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    func getIcon() -> UIImage? {
        return UIImage(named: "\(self.rawValue)Icon")
    }
    
    func getBigImage() -> UIImage? {
        return UIImage(named: "\(self.rawValue)Bg")
    }
    
    func getCellPosition() -> PrivilegeTypeCell.Position {
        switch self {
        case .all:
            return .first
        case .spa:
            return .last
        default:
            return .mid
        }
    }
}

struct PrivilegeModel {
    let type: PrivilegeType
    let titleTh: String
    let titleEn: String
}

enum PromotionType: String {
    case bond
    case covid
    case vaccine
    
    func getImage() -> UIImage? {
        return UIImage(named: self.rawValue)
    }
}

struct PromotionModel {
    let type: PromotionType
    let title: String
}

struct NewsModel {
    let imageUrl: String
    let title: String
}
