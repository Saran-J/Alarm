//
//  PrivilegeCell.swift
//  Alarm
//
//  Created by KTB_User on 30/6/2564 BE.
//

import UIKit

class PrivilegeCell: UICollectionViewCell {
    @IBOutlet weak var titleTh: UILabel!
    @IBOutlet weak var titleEn: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    var onClick: (() -> Void) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellData(titleTh: String, titleEn: String, image: UIImage, onClick: @escaping (() -> Void)) {
        self.titleTh.text = titleTh
        self.titleEn.text = titleEn
        self.image.image = image
        self.onClick = onClick
    }
}
