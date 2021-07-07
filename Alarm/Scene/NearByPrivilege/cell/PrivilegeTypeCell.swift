import UIKit

class PrivilegeTypeCell: UICollectionViewCell {
    enum Position {
        case first, mid, last
    }
    
    var isActive = false {
        didSet {
            roundBg.isHidden = !isActive
            titleLabel.textColor = isActive ? .black : .white
        }
    }
    
    @IBOutlet weak var mainBg: UIView!
    @IBOutlet weak var roundBg: RoundCornerView!
    @IBOutlet weak var roundLeft: UIView!
    @IBOutlet weak var roundRight: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        isActive = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.setupRoundLeft()
            self.setupRoundRight()
        }
    }
    
    func setupCell(title: String, pos: Position) {
        titleLabel.text = title
        switch pos {
        case .first:
            manageFirstCell()
        case .last:
            manageLastCell()
        case .mid:
            manageMidCell()
        }
    }
    
    private func setupRoundLeft() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = roundLeft.frame
        rectShape.position = roundLeft.center
        rectShape.path = UIBezierPath(
            roundedRect: roundLeft.bounds,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: 16, height: 16)
        ).cgPath
        roundLeft.layer.mask = rectShape
    }
    
    private func setupRoundRight() {
        let rectShape = CAShapeLayer()
        rectShape.bounds = roundRight.frame
        rectShape.position = roundRight.center
        rectShape.path = UIBezierPath(
            roundedRect: roundRight.bounds,
            byRoundingCorners: [.topRight, .bottomRight],
            cornerRadii: CGSize(width: 16, height: 16)
        ).cgPath
        roundRight.layer.mask = rectShape
    }
    
    private func manageFirstCell() {
        mainBg.isHidden = true
        roundLeft.isHidden = false
        roundRight.isHidden = true
    }
    
    private func manageLastCell() {
        mainBg.isHidden = true
        roundLeft.isHidden = true
        roundRight.isHidden = false
    }
    
    private func manageMidCell() {
        mainBg.isHidden = false
        roundLeft.isHidden = true
        roundRight.isHidden = true
    }
}
