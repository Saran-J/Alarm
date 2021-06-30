import Foundation
import UIKit

class PromotionDelegate: NSObject, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let promotionData: [PromotionModel] = [
        PromotionModel(
            type: .bond,
            title: "พันธบัตรออมทรัพย์รุ่นยิ่งออมยิ่งได้ บนวอลเล็ต สบม. ดอกเบี้ยสูงสุด 2.2%"
        ),
        PromotionModel(
            type: .covid,
            title: "กรุงไทยเคียงข้างลูกค้าฝ่าวิกฤติด้วยมาตรการช่วยเหลือลูกค้าบุคคลและลูกค้าธุรกิจ"
        ),
        PromotionModel(
            type: .vaccine,
            title: "ไทยร่วมใจ กรุงเทพปลอดภัย"
        )
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotionData.count + 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == 0 || indexPath.row == promotionData.count + 1 {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "blankCell",
                for: indexPath
            )
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "promotionCell",
                for: indexPath) as? PromotionCell else {
            return UICollectionViewCell()
        }
        
        let data = promotionData[indexPath.row - 1]
        cell.setupCellData(
            title: data.title,
            image: data.type.getImage() ?? UIImage()
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == promotionData.count + 1 {
            return CGSize(width: 8, height: 221)
        }
        return CGSize(width: 320, height: 221)
    }
}
