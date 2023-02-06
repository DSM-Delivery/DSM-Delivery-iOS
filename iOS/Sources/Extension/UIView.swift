import UIKit
import SnapKit
import Then
extension UIView {
    func setShadow(radius: CGFloat) {
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = radius
    }
}
