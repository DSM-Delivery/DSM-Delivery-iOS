import UIKit
import SnapKit
import Then

extension UIButton {
    typealias DSMDeliveryColor = DSMDeliveryAsset.Color
    typealias DSMDeliveryImage = DSMDeliveryAsset.Assets
    func setComponent(title: String, font: UIFont, image: UIImage?, color: UIColor) {
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.setImage(image, for: .normal)
        self.tintColor = color
    }
    func imagePadding(padding: CGFloat) {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = padding
        self.configuration = configuration
    }
    func isOn() {
        self.setImage(DSMDeliveryImage.check.image, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 0
        self.backgroundColor = DSMDeliveryColor.green400.color
        self.tintColor = DSMDeliveryColor.light.color
    }
    func isOff() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = DSMDeliveryColor.gray200.color.cgColor
        self.backgroundColor = DSMDeliveryColor.light.color
        self.tintColor = DSMDeliveryColor.light.color
    }
}
