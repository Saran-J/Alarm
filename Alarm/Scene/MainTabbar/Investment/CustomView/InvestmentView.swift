import UIKit

class InvestmentView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cornerView: RoundCornerView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var typeValueLabel: UILabel!
    @IBOutlet weak var changeValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InvestmentView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    public func setupView(data: InvestmentData) {
        cornerView.backgroundColor = data.type.valueColor
        typeLabel.text = data.type.valueLabel
        typeValueLabel.text = data.value
        typeValueLabel.textColor = data.type.valueColor
        changeValueLabel.isHidden = data.percentageChange.isEmpty
        if data.percentageChange.hasPrefix("-") {
            changeValueLabel.textColor = UIColor.colorWithRGBA(
                236,
                41,
                41)
            changeValueLabel.text = data.percentageChange
        } else {
            changeValueLabel.textColor = UIColor.colorWithRGBA(
                103,
                172,
                14)
            changeValueLabel.text = "+\(data.percentageChange)"
        }
    }
}
