import UIKit
import SnapKit
import Then

class ProFileView: UIView {
    let proFileImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DSMDeliveryAsset.Color.gray200.color.cgColor
    }
    let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        $0.text = "양운석"
        $0.textColor = DSMDeliveryAsset.Color.gray600.color
    }
    let useCountLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = DSMDeliveryAsset.Color.gray400.color
        $0.text = "이용횟수 : 12"
    }
    override func layoutSubviews() {
        self.backgroundColor = DSMDeliveryAsset.Color.light.color
        [
            proFileImageView,
            nameLabel,
            useCountLabel
        ].forEach { addSubview($0) }

        proFileImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(60)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(proFileImageView.snp.trailing).offset(15)
            $0.top.equalToSuperview().inset(24)
        }
        useCountLabel.snp.makeConstraints {
            $0.leading.equalTo(proFileImageView.snp.trailing).offset(15)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
        }
    }
}
