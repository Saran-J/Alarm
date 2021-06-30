import Foundation
import UIKit

enum PrivilegeType: String {
    case parking
    case lounge
    case fitness
    case spa
    
    func getImage() -> UIImage? {
        return UIImage(named: self.rawValue)
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
