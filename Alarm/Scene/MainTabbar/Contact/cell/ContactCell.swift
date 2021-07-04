//
//  ContactCell.swift
//  Alarm
//
//  Created by KTB_User on 5/7/2564 BE.
//

import UIKit

class ContactCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        // Initialization code
    }
    
    func setupCellData(data: ContactModel) {
        nameLabel.text = data.name
        nicknameLabel.text = "(\(data.nickname))"
        dateLabel.text = "ติดต่อล่าสุด : \(data.latestContactDate)"
        imageView.image = UIImage(named: data.imageUrl)
    }
}
