import Foundation
import RxSwift
import RxCocoa

class TabViewController: BaseViewController {
    var onRoute = PublishRelay<UIViewController>()
}
