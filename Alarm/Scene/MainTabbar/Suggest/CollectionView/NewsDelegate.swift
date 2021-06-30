import Foundation
import UIKit
import Kingfisher

class NewsDelegate: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    let newsData: [NewsModel] = [
        NewsModel(
            imageUrl: "https://image.bangkokbiznews.com/kt/media/image/news/2021/06/30/946320/750x422_946320_1625046639.jpg",
            title: "โควิดสายพันธุ์เดลต้า ทุบ 'หุ้นไทย' ปิดตลาดร่วง 3.64 จุด"
        ),
        NewsModel(
            imageUrl: "https://image.bangkokbiznews.com/kt/media/image/news/2021/06/25/945495/750x422_945495_1624616163.jpg",
            title: "5 อันดับหุ้นซื้อขายสูงสุดวันนี้ KCE นำโด่ง 3.5 พันล้าน ทำกำไร..."
        ),
        NewsModel(
            imageUrl: "https://image.bangkokbiznews.com/kt/media/image/news/2021/06/30/946252/750x422_946252_1625031979.jpg",
            title: "ความแตกต่าง ระหว่าง 'หุ้นไทย' กับ 'หุ้นเวียดนาม'"
        )
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsData.count + 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == 0 || indexPath.row == newsData.count + 1 {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "blankCell",
                for: indexPath
            )
        }
        
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "newsCell",
                for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
        
        let data = newsData[indexPath.row - 1]
        cell.setupCellData(title: data.title, imageUrl: data.imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == newsData.count + 1 {
            return CGSize(width: 8, height: 233)
        }
        return CGSize(width: 148, height: 233)
    }
}
