import UIKit

extension UIViewController {
    func presentButtonSheet(nextVC: UIViewController, height: CGFloat, radius: CGFloat) {
        let nextVC = nextVC
        if #available(iOS 16.0, *) {
            if let sheet = nextVC.sheetPresentationController {
                let id = UISheetPresentationController.Detent.Identifier("frist")
                let detent = UISheetPresentationController.Detent.custom(identifier: id) { _ in
                    return height
                }
                sheet.detents = [detent]
                sheet.preferredCornerRadius = radius
                self.present(nextVC, animated: true)
            }
        }
    }
}
