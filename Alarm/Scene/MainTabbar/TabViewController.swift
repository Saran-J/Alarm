import Foundation
import RxSwift
import RxCocoa

class TabViewController: BaseViewController {
    var onRoute = PublishRelay<UIViewController>()
    
    @IBOutlet weak var notificationView: NotificationIconView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageNewNotification()
    }
    
    func manageNewNotification() {
        notificationView.newNotification.isHidden = true
    }
}
