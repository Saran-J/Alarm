import UIKit

class RoundCornerView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layoutView() {
        layer.cornerRadius = cornerRadius
    }
    
    override func layoutSubviews() {
        layoutView()
    }
}
