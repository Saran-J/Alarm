import UIKit

@objc protocol SuggestRoutingLogic {
}

protocol SuggestDataPassing {
    var dataStore: SuggestDataStore? { get }
}

class SuggestRouter: NSObject, SuggestRoutingLogic, SuggestDataPassing {
    weak var viewController: SuggestViewController?
    var dataStore: SuggestDataStore?
}
