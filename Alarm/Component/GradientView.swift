import UIKit
@IBDesignable
class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .black {
        didSet { updateColors() }
    }
    @IBInspectable var endColor: UIColor = .white {
        didSet { updateColors() }
    }
    @IBInspectable var horizontalMode: Bool = false {
        didSet { updatePoints() }
    }
    @IBInspectable var showShadow: Bool = true {
        didSet { updateColors() }
    }
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    func updateShadow() {
        layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowOpacity = 0.1
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateColors()
    }
}
