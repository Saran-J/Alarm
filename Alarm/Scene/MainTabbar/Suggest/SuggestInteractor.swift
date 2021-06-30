import UIKit

protocol SuggestBusinessLogic {
}

protocol SuggestDataStore {
}

class SuggestInteractor: SuggestBusinessLogic, SuggestDataStore {
    var presenter: SuggestPresentationLogic?
    var worker: SuggestWorker?
}
