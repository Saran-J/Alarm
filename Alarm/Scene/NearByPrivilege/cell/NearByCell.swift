import UIKit

class NearByCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCellData(data: NearByPrivilegeResponse) {
        let category = PrivilegeType(rawValue: data.category) ?? PrivilegeType.all
        icon.image = category.getIcon()
        backgroundImage.image = category.getBigImage()
        distance.text = "\(String(format: "%.2f", data.distance)) กิโลเมตร"
        name.text = data.name
        type.text = category.getName()
    }
}
