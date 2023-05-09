import UIKit

extension UITextView {
    func setWriteTextView(placeholderText: String) {
        self.text = placeholderText
        self.font = .systemFont(ofSize: 16)
        self.backgroundColor = .systemBackground
    }
}
