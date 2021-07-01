import UIKit

protocol ProfileBusinessLogic {
}

protocol ProfileDataStore {
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
}
