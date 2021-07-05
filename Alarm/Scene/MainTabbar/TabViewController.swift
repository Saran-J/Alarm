import Foundation
import RxSwift
import RxCocoa

class TabViewController: BaseViewController {
    var onRoute = PublishRelay<UIViewController>()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var notificationView: NotificationIconView!
}
