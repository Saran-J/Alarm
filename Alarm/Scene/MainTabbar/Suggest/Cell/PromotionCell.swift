import UIKit

class PromotionCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellData(title: String, image: UIImage) {
        self.titleLabel.text = title
        self.image.image = image
    }
}
