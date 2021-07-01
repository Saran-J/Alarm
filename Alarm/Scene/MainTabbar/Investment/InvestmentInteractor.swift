import UIKit

protocol InvestmentBusinessLogic {
}

protocol InvestmentDataStore {
}

class InvestmentInteractor: InvestmentBusinessLogic, InvestmentDataStore {
    var presenter: InvestmentPresentationLogic?
    var worker: InvestmentWorker?
}
