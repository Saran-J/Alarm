import Foundation
import UIKit

extension UIFont {
    enum KtbFontStyle: String {
        case regular = "Regular"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case ultraLight = "UltraLight"
        case ultraLightItalic = "UltraLightItalic"
    }
    static var ktbFontPrefix = "KrungthaiFast"
    
    class func ktbFont(size: CGFloat, style: KtbFontStyle) -> UIFont {
        return UIFont(
            name: "\(ktbFontPrefix)-\(style.rawValue)",
            size: size
        ) ?? UIFont()
    }
}
