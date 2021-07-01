import UIKit

@objc protocol InvestmentRoutingLogic {
}

protocol InvestmentDataPassing {
    var dataStore: InvestmentDataStore? { get }
}

class InvestmentRouter: NSObject, InvestmentRoutingLogic, InvestmentDataPassing {
    weak var viewController: InvestmentViewController?
    var dataStore: InvestmentDataStore?
}
