import UIKit

protocol RegisterBusinessLogic {
}

protocol RegisterDataStore {
}

class RegisterInteractor: RegisterBusinessLogic, RegisterDataStore {
    var presenter: RegisterPresentationLogic?
    var worker: RegisterWorker?
}
