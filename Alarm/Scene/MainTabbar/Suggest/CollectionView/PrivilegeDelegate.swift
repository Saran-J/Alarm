import Foundation
import UIKit

class PrivilegeDelegate: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    let privilegeData: [PrivilegeModel] = [
        PrivilegeModel(
            type: .parking,
            titleTh: "พื้นที่จอดรถ",
            titleEn: "Resereve Parking"
        ),
        PrivilegeModel(
            type: .lounge,
            titleTh: "ห้องรับรองพิเศษ",
            titleEn: "Precious Lounge"
        ),
        PrivilegeModel(
            type: .fitness,
            titleTh: "ฟิตเนส",
            titleEn: "Fitness"
        ),
        PrivilegeModel(
            type: .spa,
            titleTh: "สปา",
            titleEn: "Health & Spa"
        )
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return privilegeData.count + 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == 0 || indexPath.row == privilegeData.count + 1 {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "blankCell",
                for: indexPath
            )
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "privilegeCell",
                for: indexPath) as? PrivilegeCell else {
            return UICollectionViewCell()
        }
        
        let data = privilegeData[indexPath.row - 1]
        cell.setupCellData(
            titleTh: data.titleTh,
            titleEn: data.titleEn,
            image: data.type.getImage() ?? UIImage()) {
            print(data.type)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == privilegeData.count + 1 {
            return CGSize(width: 8, height: 139)
        }
        return CGSize(width: 219, height: 141)
    }
}
