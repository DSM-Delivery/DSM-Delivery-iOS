import UIKit

extension UILabel {
    func setLabel(text: String) {
        self.text = text
        textColor = DSMDeliveryAsset.Color.primary.color
        font = UIFont.systemFont(ofSize: 30, weight: .bold)
    }
}
