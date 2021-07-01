import UIKit

enum Investment {
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}

struct ChartData {
    let value: Double
    let title: String
    let color: UIColor
}

enum InvestmentType {
    case saving
    case stock
    case fund
    
    var valueColor: UIColor {
        switch self {
        case .saving:
            return UIColor.colorWithRGBA(94, 139, 142)
        case .fund:
            return UIColor.colorWithRGBA(184, 148, 154)
        case .stock:
            return UIColor.colorWithRGBA(46, 119, 186)
        }
    }
    
    var valueLabel: String {
        switch self {
        case .saving:
            return "เงินฝาก"
        case .fund:
            return "กองทุนรวม"
        case .stock:
            return "หลักทรัพย์"
        }
    }
}

struct InvestmentData {
    let type: InvestmentType
    let value: String
    let percentageChange: String
}
