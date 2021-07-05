import UIKit

class NotificationIconView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var newNotification: RoundCornerView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("NotificationIconView", owner: self, options: nil)
        addSubview(contentView)
        self.backgroundColor = .clear
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
