import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func setTextField(forTextField: UITextField, placeholder: String) {
        forTextField.layer.borderWidth = 1
        forTextField.layer.cornerRadius = 10
        forTextField.layer.borderColor =  DSMDeliveryAsset.Color.gray200.color.cgColor
        forTextField.placeholder = placeholder
        forTextField.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    func setNumberTextField(forTextField: UITextField) {
        forTextField.layer.borderWidth = 1
        forTextField.layer.cornerRadius = 10
        forTextField.layer.borderColor =  DSMDeliveryAsset.Color.gray200.color.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 17, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        forTextField.keyboardType = .numberPad
    }
    func setTitleTextField(forTextField: UITextField, placeholderText: String) {
        forTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            .foregroundColor: DSMDeliveryAsset.Color.gray300.color,
            .font: UIFont.boldSystemFont(ofSize: 22.0)
        ])
        forTextField.layer.borderWidth = 0

    }
}
