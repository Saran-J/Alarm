import Foundation
import RxSwift
import RxCocoa

class TabViewController: BaseViewController {
    var onRoute = PublishRelay<UIViewController>()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var notificationView: NotificationIconView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageNewNotification()
    }
    
    func manageNewNotification() {
        notificationView.newNotification.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.setupHeader()
        }
    }

    func setupHeader() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.headerView.frame
        rectShape.position = self.headerView.center
        rectShape.path = UIBezierPath(
            roundedRect: self.headerView.bounds,
            byRoundingCorners: [.bottomLeft],
            cornerRadii: CGSize(width: 25, height: 25)
        ).cgPath
        self.headerView.layer.mask = rectShape
    }
}
