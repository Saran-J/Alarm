import Foundation
import UIKit

extension UIColor {
    class func colorWithRGBA(
        _ r: CGFloat,
        _ g: CGFloat,
        _ b: CGFloat,
        _ a: CGFloat = 1.0
    ) -> UIColor {
        return UIColor(
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            alpha: a
        )
    }
}
