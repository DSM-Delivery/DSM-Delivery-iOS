import UIKit
import SnapKit
import Then

class RiderMenuButton: UIButton {
    let titleTextLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    override func layoutSubviews() {
        addSubview(titleTextLabel)
        titleTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview()
        }
    }
}
