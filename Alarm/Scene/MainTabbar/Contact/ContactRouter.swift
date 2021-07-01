import UIKit

@objc protocol ContactRoutingLogic {
}

protocol ContactDataPassing {
    var dataStore: ContactDataStore? { get }
}

class ContactRouter: NSObject, ContactRoutingLogic, ContactDataPassing {
    weak var viewController: ContactViewController?
    var dataStore: ContactDataStore?
}
