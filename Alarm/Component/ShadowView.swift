import Foundation
import UIKit

class ShadowView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0
    var shadowLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func layoutView() {
        layer.cornerRadius = cornerRadius
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            
            shadowLayer?.shadowColor = UIColor(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0.5).cgColor
            shadowLayer?.shadowPath = shadowLayer?.path
            shadowLayer?.shadowOffset = CGSize(width: 0, height: 1.0)
            shadowLayer?.shadowOpacity = 0.5
            shadowLayer?.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer ?? CAShapeLayer(), at: 0)
        }
    }
    
    override func layoutSubviews() {
        layoutView()
    }
}
