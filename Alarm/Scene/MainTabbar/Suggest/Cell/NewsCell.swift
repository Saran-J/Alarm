import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCellData(title: String, imageUrl: String) {
        self.titleLabel.text = title
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
        let url = URL(string: imageUrl)
        image.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
