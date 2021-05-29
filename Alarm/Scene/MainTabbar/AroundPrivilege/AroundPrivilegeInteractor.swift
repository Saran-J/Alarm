import UIKit

protocol AroundPrivilegeBusinessLogic {
}

protocol AroundPrivilegeDataStore {
}

class AroundPrivilegeInteractor: AroundPrivilegeBusinessLogic, AroundPrivilegeDataStore {
    var presenter: AroundPrivilegePresentationLogic?
    var worker: AroundPrivilegeWorker?
}
